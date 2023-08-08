return {
  'goolord/alpha-nvim',
  config = function()
    local dashboard = require 'alpha.themes.dashboard'
    local theta = require 'alpha.themes.theta'

    theta.header.val = {
      [[]],
      [[                      ██████                     ]],
      [[                  ████▒▒▒▒▒▒████                 ]],
      [[                ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒██               ]],
      [[              ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██             ]],
      [[            ██▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒               ]],
      [[            ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▓▓▓▓           ]],
      [[            ██▒▒▒▒▒▒  ▒▒▓▓▒▒▒▒▒▒  ▒▒▓▓           ]],
      [[          ██▒▒▒▒▒▒▒▒▒▒    ▒▒▒▒▒▒▒▒    ██         ]],
      [[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
      [[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
      [[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
      [[          ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██         ]],
      [[          ██▒▒██▒▒▒▒▒▒██▒▒▒▒▒▒▒▒██▒▒▒▒██         ]],
      [[          ████  ██▒▒██  ██▒▒▒▒██  ██▒▒██         ]],
      [[          ██      ██      ████      ████         ]],
      [[                                                 ]],
      [[]],
    }

    local fortune = require 'alpha.fortune' ()
    local footer = {
      type = 'text',
      val = fortune,
      opts = {
        position = 'center',
        hl = 'Comment',
        hl_shortcut = 'Comment',
      },
    }

    local buttons = {
      type = 'group',
      val = {
        dashboard.button('e', '  New file', '<cmd>ene <CR>'),
        dashboard.button('SPC f', '  Find file'),
        dashboard.button('SPC s r', '  Recently opened files'),
        dashboard.button('SPC s g', '  Find word'),
      },
      opts = {
        spacing = 0,
      },
    }

    local buttonsBottom = {
      type = 'group',
      val = {
        dashboard.button('C', '  Configuration', '<cmd>e ~/.config/nvim/init.lua <CR>'),
        dashboard.button('L', '  Lazy plugins', '<cmd>Lazy<CR>'),
        dashboard.button('M', '  Mason lsp/dap/linter/formatter', '<cmd>Mason<CR>'),
        dashboard.button('q', '  Quit', '<cmd>qa<CR>'),
      },
      opts = {
        spacing = 0,
      },
    }

    local padding = { type = 'padding', val = 2 }

    -- TODO: cleaner way to do this?
    theta.config.layout = {
      theta.header,
      padding,
      buttons,
      padding,
      buttonsBottom,
      padding,
      footer,
    }

    require('alpha').setup(theta.config)
  end,
}
