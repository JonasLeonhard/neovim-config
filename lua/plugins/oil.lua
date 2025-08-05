local oil_window_state = {}
local detail = false -- show extra filedata toggle

local remember_window_state = function()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_buf_filetype = vim.api.nvim_get_option_value("filetype", { buf = current_buf })

  if current_buf_filetype == "oil" then
    oil_window_state[current_win] = nil
  else
    oil_window_state[current_win] = {
      original_buf = current_buf
    }
  end
end

local open_oil_with_state = function(open_opts)
  remember_window_state()

  local bufname = vim.fn.expand('%:t')
  require("oil").open(open_opts, nil, function()
    pcall(vim.cmd, '/' .. bufname .. '$') -- dont throw an error if we cant find the bufname
  end)
end

local toggle_oil = function(open_opts)
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_buf_filetype = vim.api.nvim_get_option_value("filetype", { buf = current_buf })

  -- Check if current window is showing oil
  if current_buf_filetype == "oil" then
    -- We're in an oil buffer, close it and return to original buffer
    local state = oil_window_state[current_win]
    if state and state.original_buf and vim.api.nvim_buf_is_valid(state.original_buf) then
      vim.api.nvim_set_current_buf(state.original_buf)
    end
    -- Clear state for this window
    oil_window_state[current_win] = nil
  else
    -- We're in a regular buffer, open oil and remember it
    open_oil_with_state(open_opts)
  end
end

vim.api.nvim_create_autocmd("WinClosed", {
  callback = function(args)
    local win_id = tonumber(args.match)
    if win_id and oil_window_state[win_id] then
      oil_window_state[win_id] = nil
    end
  end,
})

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
                  open_oil_with_state(item.text)
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
      require("lz.n").trigger_load("mini.icons") -- requirement for oil
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
              require("oil").select(nil)
            end,
            desc = "Open file and maximize window",
          },
          ["<leader>sf"] = {
            callback = function()
              local oil = require("oil")
              local current_dir = oil.get_current_dir()

              Snacks.picker.files({
                cwd = current_dir,
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
                      open_oil_with_state(current_dir .. item.text)
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
