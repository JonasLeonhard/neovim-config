local detail = false

local toggle_oil = function(dir)
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

    local oil = require('oil');
    local M = require("helper");
    M.smart_split()

    oil.open(dir, nil, function()
      -- Get the current window
      local win = vim.api.nvim_get_current_win()
      local buf = vim.api.nvim_win_get_buf(win)

      -- Only search if we're in an oil buffer
      if vim.bo[buf].filetype == "oil" then
        pcall(vim.cmd, '/' .. bufname .. '$') -- dont throw an error if we cant find the bufname
      end
    end)
  end
end

local close_all_oil_if_picked = function()
  -- -- Check if current buffer is not an oil buffer
  if vim.bo.filetype ~= "oil" then
    -- We picked a file -> Close all oil windows
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.api.nvim_get_option_value("filetype", { buf = buf }) == "oil" then
        vim.api.nvim_win_close(win, false)
      end
    end
  end
end

return {
  pack = {
    src = 'https://github.com/stevearc/oil.nvim',
  },
  lazy = {
    "oil.nvim",
    cmd = { "Oil" },
    keys = {
      {
        '<leader>e',
        function()
          toggle_oil(vim.fn.expand('%:p:h'))
        end,
        desc = 'Oil'
      },
      {
        '<leader>E',
        function()
          toggle_oil(vim.fn.getcwd())
        end,
        desc = 'Oil (cwd)'
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.pick({
            source = "Directories",
            cwd = vim.fn.getcwd(),
            finder = function(opts, ctx)
              return require("snacks.picker.source.proc").proc({
                opts,
                {
                  cmd = "fd",
                  args = {
                    "--type",
                    "d",
                    "--hidden",
                    "--exclude",
                    ".git",
                  },
                },
              }, ctx)
            end,
            format = "text",

            -- Configure action to open the selected directory in Oil
            confirm = function(picker, item)
              if item then
                picker:close()
                vim.schedule(function()
                  toggle_oil(item.text)
                end)
              end
            end,

            -- Enable preview with tree if available
            preview = function(ctx)
              local item = ctx.item
              if not item or not item.text then return false end

              local tree_output = vim.fn.system({ "tree", item.text })
              vim.bo[ctx.buf].modifiable = true
              vim.api.nvim_buf_set_lines(ctx.buf, 0, -1, false, vim.split(tree_output, "\n"))
              return true
            end,
          })
        end,
        desc = "Search Directories"
      }
    },
    before = function()
      require("lz.n").trigger_load("mini.icons") -- just in case we are faster than the deferred setup
    end,
    after = function()
      require("oil").setup({
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
                  vim.cmd("tabonly")
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
            callback = function()
              local oil = require("oil")
              local current_dir = oil.get_current_dir()

              Snacks.picker.files({
                cwd = current_dir,
                on_close = close_all_oil_if_picked
              })
            end,
            mode = "n",
            nowait = true,
            desc = "Find files in the current (Oil) directory"
          },
          ["<leader>sg"] = {
            callback = function()
              local oil = require("oil")
              local current_dir = oil.get_current_dir()

              Snacks.picker.grep({
                cwd = current_dir,
                on_close = close_all_oil_if_picked
              })
            end,
            mode = "n",
            nowait = true,
            desc = "ripgrep in the current (Oil) directory"
          },
          ["<leader>sd"] = {
            callback = function()
              local oil = require("oil")
              local current_dir = oil.get_current_dir()

              Snacks.picker.pick({
                source = "Directories",
                cwd = current_dir,
                finder = function(opts, ctx)
                  return require("snacks.picker.source.proc").proc({
                    opts,
                    {
                      cmd = "fd",
                      args = {
                        "--type",
                        "d",
                        "--hidden",
                        "--exclude",
                        ".git",
                      },
                    },
                  }, ctx)
                end,
                format = "text",

                -- Configure action to open the selected directory in Oil
                confirm = function(picker, item)
                  if item then
                    picker:close()
                    vim.schedule(function()
                      toggle_oil() -- TODO: find better way to open in split
                      toggle_oil(current_dir .. item.text)
                    end)
                  end
                end,

                -- Enable preview with tree if available
                preview = function(ctx)
                  local item = ctx.item
                  if not item or not item.text then return false end

                  local tree_output = vim.fn.system({ "tree", item.text })
                  vim.bo[ctx.buf].modifiable = true
                  vim.api.nvim_buf_set_lines(ctx.buf, 0, -1, false, vim.split(tree_output, "\n"))
                  return true
                end,
              })
            end,
            mode = "n",
            nowait = true,
            desc = "Find subdirectories in the current (Oil) directory"
          },
          ["g$"] = {
            callback = function()
              local oil = require("oil")
              local current_dir = oil.get_current_dir()
              vim.cmd("botright split | lcd " .. current_dir .. " | terminal")
            end,
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
        },
      })
    end
  }
}
