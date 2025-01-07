local search_files = function()
  local M = require("user.config.fuzzy");
  local oil = require("oil");
  local current_dir = oil.get_current_dir()

  local cmd = "cd " .. current_dir .. "; rg --files " ..
      table.concat(M.rg_default_opts, " ") .. " . | fzf " .. table.concat(M.default_fuzzy_opts, " ");

  local callback = function(stdout)
    local selected_files = vim.split(stdout, "\n")
    local qf_list = {}
    for idx, file in ipairs(selected_files) do
      if (idx ~= #selected_files) then -- the first path is the start dir
        local joined_path = vim.fn.simplify(current_dir .. file)

        table.insert(qf_list, {
          filename = joined_path,
          lnum = 1,
        })
      end
      if #qf_list > 0 then
        vim.cmd("edit " .. qf_list[1].filename)
        vim.cmd("only")

        if (#qf_list > 1) then
          vim.fn.setqflist(qf_list)
          vim.cmd("copen")
        end
      end
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

      local current_dir = oil.get_current_dir()
      local cmd =
          [[cd ]] .. current_dir .. "; " ..
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
          local joined_path = vim.fn.simplify(current_dir .. file_path)

          vim.api.nvim_command("edit +" .. line .. " " .. joined_path)
          vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col) - 1 })
          vim.cmd("only")
        else
          -- For Multiple results: add all to quickfix list and open the first one
          local qf_list = {}
          for _, file in ipairs(selected_files) do
            local file_path, line, col, text = file:match("([^:]+):(%d+):(%d+):(.*)")
            local joined_path = vim.fn.simplify(current_dir .. file_path)

            table.insert(qf_list, {
              filename = joined_path,
              lnum = tonumber(line),
              col = tonumber(col),
              text = text
            })
          end

          vim.fn.setqflist(qf_list)

          if #qf_list > 0 then
            vim.cmd("cfirst")
            vim.cmd("only")
            vim.cmd("copen")
          end
        end
      end
      M.fuzzy_search({ cmd = cmd, callback = callback })
    end)
end

local terminal_dir = function()
  local oil = require("oil")
  local current_dir = oil.get_current_dir()
  vim.cmd("split | lcd " .. current_dir .. " | terminal")
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

local toggle_oil = function(cmd)
  -- Check if any oil buffers are open
  local oil_windows = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:match("^oil://") then
      table.insert(oil_windows, win)
    end
  end

  if #oil_windows > 0 then
    -- Close all oil windows
    for _, win in ipairs(oil_windows) do
      pcall(vim.api.nvim_win_close, win, false)
    end
  else
    local bufname = vim.fn.expand('%:t')

    if (bufname ~= '') then
      -- Open new oil window
      vim.cmd(cmd)

      vim.defer_fn(function()
        -- Get the current window
        local win = vim.api.nvim_get_current_win()
        local buf = vim.api.nvim_win_get_buf(win)

        -- Only search if we're in an oil buffer
        if vim.bo[buf].filetype == "oil" then
          pcall(vim.cmd, '/' .. bufname .. '$') -- dont throw an error if we cant find the bufname
        end
      end, 50)
    else
      vim.cmd(cmd)
    end
  end
end

local detail = false

return {
  'stevearc/oil.nvim',
  lazy = true,
  cmd = { "Oil" },
  keys = {
    {
      '<leader>e',
      function()
        toggle_oil('split | Oil %:p:h')
      end,
      desc = 'Oil'
    },
    {
      '<leader>E',
      function()
        toggle_oil('split | Oil' .. vim.fn.getcwd())
      end,
      desc = 'Oil (cwd)'
    },
  },
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    cleanup_delay_ms = 0,
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
      ["g<CR>"] = {
        callback = function()
          require("oil").select(nil)
        end,
        desc = "Open file",
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
      ["g$"] = {
        terminal_dir,
        mode = "n",
        nowait = true,
        desc = "Terminal in (Oil) directory"
      },
      ["gd"] = {
        desc = "Toggle file detail view",
        callback = function()
          detail = not detail
          if detail then
            require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
          else
            require("oil").set_columns({ "icon" })
          end
        end,
      },
      ["<C-z>"] = {
        desc = "Toggle Broil",
        callback = function()
          local oil = require("oil");
          local current_dir = oil.get_current_dir()
          local broil = require("broil")

          toggle_oil('split | Oil %:p:h') -- close all oil windows
          broil.open(current_dir)
        end
      }
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
