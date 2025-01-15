local M = {
  rg_default_opts    = {
    "--column",
    "--line-number",
    "--no-heading",
    "--smart-case",
    "--hidden",
    "-g !.astro/",
    "-g !.git/",
    "-g !.godot/",
    "-g !.next/",
    "-g !.svelte-kit/",
    "-g !build/",
    "-g !dist/",
    "-g !media/",
    "-g !node_modules/",
    "-g !release/",
    "-g !storybook-static/",
    "-g !target/",
    "-g !tmp/",
    "-g !vendor/",
    "-g !.zig-cache/",
    "-g !zig-out/",
    "-g !yarn.lock",
    "-g !package.lock",
    "-g !.cache/"
  },
  default_fuzzy_opts = {
    '-m',
    "--pointer=''",
    "--prompt ''",
    "--separator=''",
    "--info='right'",
    "--preview-window 'noborder'",
    "--color=bg+:#1e1e2e,fg+:#cdd6f4,hl:#f9e2af,hl+::#f9e2af"
  },
}

--- @class FuzzySearchOptions
--- @field cmd string command to run in a seperate split, eg: "git ls-file | fzf".
--- @field callback function callback(stdout_string) ...do your thing here... end

--- @param options FuzzySearchOptions
--- @return nil
M.run_in_split = function(options)
  -- save some state from before opening
  local open_winid = vim.fn.win_getid()

  -- Create command and input buffers
  local command_buffer = vim.api.nvim_create_buf(false, true);
  vim.cmd('botright split')
  local split_win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(split_win, command_buffer)

  -- Create a terminal job
  local file = vim.fn.tempname()
  local shell_command = {
    '/bin/sh',
    '-c',
    options.cmd .. " > " .. file
  }

  vim.api.nvim_cmd({ cmd = 'startinsert' }, { output = false })
  vim.fn.jobstart(shell_command, {
    term = true,
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
        options.callback(stdout)
      end
    end,
  })
end

M.ui_select = function(items, opts, on_choice)
  local item_map = {}
  local item_strings = vim.tbl_map(function(item)
    local item_string = opts.format_item and opts.format_item(item) or tostring(item)
    item_map[item_string] = item
    return item_string
  end, items)

  local cmd = "echo '" .. table.concat(item_strings, "\n") .. "' | fzf " ..
      table.concat(M.default_fuzzy_opts, " ") ..
      (opts.prompt and (" --prompt '" .. opts.prompt .. " '") or "")

  local callback = function(stdout)
    if stdout and stdout ~= "" then
      local selected = vim.trim(stdout)
      local original_item = item_map[selected]
      on_choice(original_item, selected and vim.v.null or nil)
    else
      on_choice(nil, nil)
    end
  end

  M.run_in_split({ cmd = cmd, callback = callback })
end

-- Set up the ui.select handler
vim.ui.select = function(items, opts, on_choice)
  M.ui_select(items, opts, on_choice)
end

M.pickers = {
  {
    key = "<leader>f",
    description = "find files (git)",
    callback = function()
      local cmd = "git ls-files | fzf " .. table.concat(M.default_fuzzy_opts, " ")
      local callback = function(stdout)
        local selected_files = vim.split(stdout, "\n")
        local qf_list = {}
        for _, file in ipairs(selected_files) do
          if (file ~= "") then
            table.insert(qf_list, {
              filename = file,
              lnum = 1,
            })
          end
        end
        if #qf_list > 0 then
          vim.cmd("edit " .. selected_files[1])
          if (#qf_list > 1) then
            vim.fn.setqflist(qf_list)
            vim.cmd("copen")
          end
        end
      end

      M.run_in_split({
        cmd = cmd,
        callback = callback,
      })
    end
  },
  {
    key = "<leader>sf",
    description = "find files (all)",
    callback = function()
      local cmd = "rg --files " ..
          table.concat(M.rg_default_opts, " ") .. " . | fzf " .. table.concat(M.default_fuzzy_opts, " ")
      local callback = function(stdout)
        local selected_files = vim.split(stdout, "\n")
        local qf_list = {}
        for _, file in ipairs(selected_files) do
          if (file ~= "") then
            table.insert(qf_list, {
              filename = file,
              lnum = 1,
            })
          end
        end
        if #qf_list > 0 then
          vim.cmd("edit " .. selected_files[1])
          if (#qf_list > 1) then
            vim.fn.setqflist(qf_list)
            vim.cmd("copen")
          end
        end
      end

      M.run_in_split({ cmd = cmd, callback = callback })
    end
  },
  {
    key = "<leader>bl",
    description = "buffers",
    callback = function()
      local buffers = vim.api.nvim_cmd(
        { cmd = 'buffers' },
        { output = true }
      )
      local cmd = "echo '" .. buffers .. "' | fzf " .. table.concat(M.default_fuzzy_opts, " ")
      local callback = function(stdout)
        vim.api.nvim_cmd(
          { cmd = 'buffer', args = { stdout:match("%d+") or 1 } },
          { output = false }
        )
      end

      M.run_in_split({ cmd = cmd, callback = callback })
    end
  },
  {
    key = "<leader>sg",
    description = "ripgrep",
    callback = function()
      vim.ui.input({ prompt = "rg " },
        function(input)
          if not input then
            return
          end

          local cmd =
              [[rg ]] .. table.concat(M.rg_default_opts, " ") .. " " .. input ..
              [[ | fzf ]] .. table.concat(M.default_fuzzy_opts, " ") ..
              [[ --delimiter ':' ]] ..
              [[--preview 'bat --color=always --highlight-line {2} {1}' ]] ..
              [[--preview-window '+{2}/2,<80(up)' ]]

          local callback = function(stdout)
            local selected_files = vim.tbl_filter(function(item) return item ~= "" end, vim.split(stdout, "\n"))

            if #selected_files == 1 then
              local file_path, line, col = selected_files[1]:match("([^:]+):(%d+):(%d+):")
              vim.api.nvim_command("edit +" .. line .. " " .. file_path)
              vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) - 1 })
            else
              local qf_list = {}
              for _, file in ipairs(selected_files) do
                local file_path, line, col, text = file:match("([^:]+):(%d+):(%d+):(.*)")
                table.insert(qf_list, {
                  filename = file_path,
                  lnum = tonumber(line),
                  col = tonumber(col),
                  text = text
                })
              end
              vim.fn.setqflist(qf_list)
              vim.cmd("copen")
              if #qf_list > 0 then
                vim.cmd("cfirst")
              end
            end
          end
          M.run_in_split({ cmd = cmd, callback = callback })
        end)
    end
  },
  {
    key = "<leader>sd",
    description = "find directories",
    callback = function()
      local cmd = "fd --type d --hidden " ..
          ". | fzf " .. table.concat(M.default_fuzzy_opts, " ")

      local callback = function(stdout)
        if stdout and stdout ~= "" then
          local selected_dir = vim.trim(stdout)
          vim.cmd("botright split | Oil " .. selected_dir)
        end
      end

      M.run_in_split({ cmd = cmd, callback = callback })
    end
  },
  {
    key = "<leader>sr",
    description = "oldfiles",
    callback = function()
      local cmd = "echo '" .. table.concat(vim.v.oldfiles, "\n") .. "' | fzf " .. table.concat(M.default_fuzzy_opts, " ")
      local callback = function(stdout)
        vim.api.nvim_cmd(
          { cmd = 'edit', args = { stdout:match("^%s*(.-)%s*$") } },
          { output = false }
        )
      end

      M.run_in_split({ cmd = cmd, callback = callback })
    end
  },
}

-- Function to set up all picker keybindings
M.setup_pickers = function()
  -- keybinds
  for _, picker in ipairs(M.pickers) do
    if picker.key then
      vim.keymap.set('n', picker.key, picker.callback, {
        desc = picker.description,
        silent = true
      })
    end
  end

  -- A selector for each picker
  vim.keymap.set('n', '<leader>sp', function()
    -- Extract just the descriptions for the picker list
    local descriptions = vim.tbl_map(function(picker)
      return picker.description
    end, M.pickers)

    vim.ui.select(descriptions, {
      prompt = "Select picker: "
    }, function(choice)
      if choice then
        -- Find and execute the chosen picker's callback
        for _, picker in ipairs(M.pickers) do
          if picker.description == choice then
            picker.callback()
            break
          end
        end
      end
    end)
  end, { desc = "select picker", silent = true })
end

M.setup_pickers()

return M
