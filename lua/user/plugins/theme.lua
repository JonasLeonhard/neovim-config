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
        telescope = {
          enabled = true,
        },
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
          base = "#0b0b12",
          mantle = "#11111a",
          crust = "#191926",
        },
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
}
