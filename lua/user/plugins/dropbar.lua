return {
  'Bekaboo/dropbar.nvim',
  opts = {
    icons = {
      ui = { bar = { separator = "  " } },
    },
    menu = {
      keymaps = {
        ["q"] = function()
          local menu = require("dropbar.api").get_current_dropbar_menu()
          if not menu then
            return
          end

          menu:close(true);
        end,
        ["h"] = function()
          local menu = require("dropbar.api").get_current_dropbar_menu()
          if not menu then
            return
          end

          menu:close(true);
        end,
        ["Q"] = function()
          local menu = require("dropbar.api").get_current_dropbar_menu()
          if not menu then
            return
          end
          menu:close(false); -- close menu and dont restore view
        end,
        ['l'] = function()
          local menu = require('dropbar.api').get_current_dropbar_menu()
          if not menu then
            return
          end
          local cursor = vim.api.nvim_win_get_cursor(menu.win)
          local component = menu.entries[cursor[1]]:first_clickable(cursor[2])
          if component then
            menu:click_on(component, nil, 1, 'l')
          end
        end,
      }
    }
  }
}
