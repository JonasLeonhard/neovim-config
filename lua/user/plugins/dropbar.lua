return {
  'Bekaboo/dropbar.nvim',
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
    general = {
      update_interval = 90,
    },
    bar = {
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

        if filetype == 'NeogitCommitMessage' or filetype == 'NeogitMergeMessage' then
          return {
            sources.path,
            utils.source.fallback {
              sources.lsp,
            },
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
      },
    },
  },
}
