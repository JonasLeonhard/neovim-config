return {
  'Bekaboo/dropbar.nvim',
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = "make"
    }
  },
  event = 'User FileOpened',
  lazy = true,
  keys = {
    {
      '<leader>cn',
      function()
        require('dropbar.api').pick()
      end,
      desc = 'dropbar pick',
    },
  },
  opts = {
    bar = {
      update_debounce = 90,
      sources = function(buf, _)
        local sources = require 'dropbar.sources'
        local utils = require 'dropbar.utils'
        local filetype = vim.bo[buf].ft

        if filetype == 'markdown' then
          return {
            sources.path,
            utils.source.fallback {
              sources.treesitter,
              sources.markdown,
              sources.lsp,
            },
          }
        end

        -- Check first line width - disable treesitter & lsp for performance on a too large single line count
        local max_line_width = 500
        local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
        local too_wide_for_treesitter = first_line and #first_line > max_line_width

        if too_wide_for_treesitter or filetype == 'NeogitCommitMessage' or filetype == 'NeogitMergeMessage' then
          return {
            sources.path
          }
        end

        return {
          sources.path,
          utils.source.fallback {
            sources.lsp,
            sources.treesitter,
          },
        }
      end,
    },
    icons = {
      ui = { bar = { separator = '  ' } },
    },
    menu = {
      keymaps = {
        ['Q'] = function()
          local menu = require('dropbar.utils').menu.get_current()
          if not menu then
            return
          end

          menu:close(true)
        end,
        ['h'] = function()
          local menu = require('dropbar.utils').menu.get_current()
          if not menu then
            return
          end

          menu:close(true)
        end,
        ['q'] = function()
          local menu = require('dropbar.utils').menu.get_current()
          if not menu then
            return
          end
          menu:close(false) -- close menu and dont restore view
        end,
        ['l'] = function()
          local menu = require('dropbar.utils').menu.get_current()
          if not menu then
            return
          end
          local cursor = vim.api.nvim_win_get_cursor(menu.win)
          local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
          if component then
            menu:click_on(component, nil, 1, 'l')
          end
        end,
        ['/'] = function()
          local menu = require('dropbar.utils').menu.get_current()

          if not menu then
            return
          end

          menu:fuzzy_find_open()
        end,
      },
    },
  },
}
