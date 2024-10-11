local M = {}

--- @param command string command to pipe to fzf "<command> | fzf"
--- @param callback function callback(stdout_string) ...do your thing here... end
M.fuzzy_search = function(command, callback)
  -- save some state from before opening
  local open_winid = vim.fn.win_getid()

  -- Create command and input buffers
  local command_buffer = vim.api.nvim_create_buf(false, true);
  vim.api.nvim_open_win(
    command_buffer,
    true,
    {
      relative = 'editor',
      style = 'minimal',
      border = 'none',
      width = vim.o.columns,
      height = math.floor(vim.o.lines / 4),
      col = 0,
      row = vim.o.lines,
      noautocmd = true,
    }
  )

  -- Create a terminal job
  local file = vim.fn.tempname()
  local shell_command = {
    '/bin/sh',
    '-c',
    command .. ' | fzy > ' .. file
  }

  vim.api.nvim_cmd({ cmd = 'startinsert' }, { output = false })
  vim.fn.termopen(shell_command, {
    on_exit = function()
      vim.api.nvim_cmd(
        { cmd = 'bdelete', bang = true },
        { output = false }
      )
      -- reset to state before opening
      if (open_winid) then
        vim.fn.win_gotoid(open_winid)
      end

      -- cleanup
      local f = io.open(file, 'r')
      if f == nil then return end
      local stdout = f:read('*all')
      f:close()
      os.remove(file)

      if (stdout ~= nil and stdout ~= '') then
        callback(stdout)
      end
    end,
  })
end

-- Keybinds
vim.keymap.set('n', '<leader>f', function()
  M.fuzzy_search("git ls-files", function(stdout)
    print("stdout: " .. stdout)
    vim.api.nvim_command("edit " .. stdout)
  end)
end, { desc = "find files (git)", silent = true })

vim.keymap.set('n', '<leader>sf', function()
  M.fuzzy_search("rg --files --no-ignore --hidden .", function(stdout)
    vim.api.nvim_command("edit " .. stdout)
  end)
end, { desc = "find files (all)", silent = true })

vim.keymap.set('n', '<leader>bl', function()
  local buffers = vim.api.nvim_cmd(
    { cmd = 'buffers' },
    { output = true }
  )
  M.fuzzy_search("echo '" .. buffers .. "'", function(stdout)
    vim.api.nvim_cmd(
      { cmd = 'buffer', args = { stdout:match("%d+") or 1 } },
      { output = false }
    )
  end)
end, { desc = "buffers", silent = true })

vim.keymap.set('n', '<leader>sg', function()
  vim.ui.input({ prompt = "rg " },
    function(input)
      if not input then
        return
      end
      M.fuzzy_search(
        "rg --column --line-number --no-heading --smart-case " ..
        input,
        function(stdout)
          local file, line, col = stdout:match("([^:]+):(%d+):(%d+):")
          if file then
            vim.api.nvim_command("edit +" .. line .. " " .. file)
            vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) - 1 })
          end
        end)
    end)
end, { desc = "ripgrep", silent = true })

vim.keymap.set('n', '<leader>sr', function()
  M.fuzzy_search("echo '" .. table.concat(vim.v.oldfiles, "\n") .. "'", function(stdout)
    vim.api.nvim_cmd(
      { cmd = 'edit', args = { stdout:match("^%s*(.-)%s*$") } }, -- trim whitespace
      { output = false }
    )
  end)
end, { desc = "oldfiles", silent = true })
return M
