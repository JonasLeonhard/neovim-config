local search_files = function()
  local M = require("user.config.fuzzy");
  local oil = require("oil");

  local cmd = "cd " .. oil.get_current_dir() .. "; rg --files " ..
      table.concat(M.rg_default_opts, " ") .. " . | fzf " .. table.concat(M.default_fuzzy_opts, " ");
  local callback = function(stdout)
    local selected_files = vim.split(stdout, "\n")
    for _, file in ipairs(selected_files) do
      vim.api.nvim_command("edit " .. file)
    end
  end

  M.fuzzy_search({ cmd = cmd, callback = callback })
end

local search_grep = function()
  local M = require("user.config.fuzzy");
  local oil = require("oil");

  vim.ui.input({ prompt = "rg (Oil) " },
    function(input)
      if not input then
        return
      end

      local cmd =
          [[cd ]] .. oil.get_current_dir() .. "; " ..
          [[rg ]] .. table.concat(M.rg_default_opts, " ") .. " " .. input ..
          [[ | fzf ]] .. table.concat(M.default_fuzzy_opts, " ") ..
          [[ --delimiter ':' ]] ..
          [[--preview 'bat --color=always --highlight-line {2} {1}' ]] ..
          [[--preview-window '+{2}/2,<80(up)' ]]

      local callback = function(stdout)
        local selected_files = vim.tbl_filter(function(item) return item ~= "" end, vim.split(stdout, "\n"))

        if #selected_files == 1 then
          -- If we have a single selected file, we just open it.
          local file_path, line, col = selected_files[1]:match("([^:]+):(%d+):(%d+):")
          vim.api.nvim_command("edit +" .. line .. " " .. file_path)
          vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) - 1 })
        else
          -- For Multiple results: add all to quickfix list and open the first one
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
      M.fuzzy_search({ cmd = cmd, callback = callback })
    end)
end

local search_dir = function()
  local M = require("user.config.fuzzy");
  local oil = require("oil");
  -- Use fd to find only directories, or fall back to find if fd isn't available
  local find_cmd = vim.fn.executable("fd") == 1
      and "fd --type d --hidden --exclude .git"
      or "find . -type d -not -path '*/.git/*'"

  local cmd = "cd " ..
      oil.get_current_dir() .. "; " .. find_cmd .. " | fzf " .. table.concat(M.default_fuzzy_opts, " ");

  local callback = function(stdout)
    if stdout and stdout ~= "" then
      -- Remove trailing newline if present
      stdout = stdout:gsub("\n$", "")
      -- Convert the selected path to absolute path
      local selected_dir = vim.fn.fnamemodify(oil.get_current_dir() .. "/" .. stdout, ":p")
      -- Open Oil in the selected directory
      vim.api.nvim_command("Oil " .. selected_dir)
    end
  end

  M.fuzzy_search({ cmd = cmd, callback = callback })
end


return {
  'stevearc/oil.nvim',
  lazy = true,
  cmd = { "Oil" },
  keys = {
    { '<leader>e', '<cmd>split | Oil %:p:h<cr>', desc = 'Netrw' },
    { '<leader>E', '<cmd>split | Oil<cr>',       desc = 'Netrw (cwd)' },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
    },
    keymaps = {
      ["<CR>"] = {
        callback = function()
          require("oil").select(nil, function()
            -- maximize the selected buffer if we're not in an oil buffer anymore
            -- (meaning we opened a file rather than entered a directory)
            if vim.bo.filetype ~= "oil" then
              vim.cmd("only")
            end
          end)
        end,
        desc = "Open file and maximize window",
      },
      ["<leader>sf"] = {
        search_files,
        mode = "n",
        nowait = true,
        desc = "Find files in the current (Oil) directory"
      },
      ["<leader>sg"] = {
        search_grep,
        mode = "n",
        nowait = true,
        desc = "ripgrep in the current (Oil) directory"
      },
      ["<leader>sd"] = {
        search_dir,
        mode = "n",
        nowait = true,
        desc = "Find subdirectories in the current (Oil) directory"
      },
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
