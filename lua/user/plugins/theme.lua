return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    event = 'VimEnter',
    opts = {
      flavour = 'mocha',
      integrations = {
        gitsigns = true,
        dap = {
          enabled = true,
          enable_ui = true,
        },
        dropbar = {
          enabled = true,
          color_mode = false,
        },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        native_lsp = {
          enabled = true,
        },
        neogit = true,
      },
      color_overrides = {
        mocha = {
          base = '#0b0b12',
          mantle = '#11111a',
          crust = '#191926',
        },
      },
      custom_highlights = function(colors)
        return {
          CmpCompletionWindowBorder = { bg = colors.mantle },
          TelescopePreviewBorder = { fg = colors.crust },
          TelescopePromptBorder = { fg = colors.crust },
          TelescopeResultsBorder = { fg = colors.crust },
          TelescopePreviewTitle = { fg = colors.crust },
          TelescopeResultsTitle = { fg = colors.crust },
          StatusLineNormal = {
            fg = colors.overlay0,
          },
          StatusLine = {
            fg = colors.overlay0,
          },
          StatusLineNC = {
            fg = colors.overlay0,
          },
          StatusLineAccent = {
            fg = colors.green,
          },
          StatuslineAccent = {
            fg = colors.green,
          },
          StatuslineInsertAccent = {
            fg = colors.yellow,
          },
          StatuslineVisualAccent = {
            fg = colors.flamingo,
          },
          StatusLineGit = {
            fg = colors.blue,
          },
          StatuslineTerminalAccent = {
            fg = colors.green,
          },
          LspDiagnosticsSignError = {
            fg = colors.red,
          },
          LspDiagnosticsSignWarning = {
            fg = colors.yellow,
          },
          LspDiagnosticsSignHint = {
            fg = colors.mauve,
          },
          LspDiagnosticsSignInformation = {
            fg = colors.blue,
          },
          MiniIndentscopeSymbol = { link = 'Comment' },
          Pmenu = { bg = colors.mantle, fg = colors.text },
          PmenuSel = { bg = colors.surface0, fg = colors.text },
          PmenuSbar = { bg = colors.mantle },
          PmenuThumb = { bg = colors.overlay0 },
        }
      end,
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
}
