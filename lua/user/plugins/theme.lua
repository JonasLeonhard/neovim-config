return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    event = "VimEnter",
    opts = {
      flavour = "mocha",
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        dap = {
          enabled = true,
          enable_ui = true,
        },
        dropbar = {
          enabled = true,
          color_mode = false
        },
        bufferline = true,
        mason = true,
        noice = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        harpoon = true,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = true,
        },
        native_lsp = {
          enabled = true,
        },
        neogit = true,
        illuminate = true
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
}
