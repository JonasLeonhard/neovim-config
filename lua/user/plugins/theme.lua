return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    opts = {
      flavour = 'mocha',
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        navic = {
          enabled = true,
        },
        dap = {
          enabled = true,
          enable_ui = true,
        },
        bufferline = true,
        hop = true,
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
      },
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme 'catppuccin'
      -- HACK: the update of neovim 0.9 broke loading different flavours. This should be removed in the future.
      vim.api.nvim_create_autocmd('VimEnter', {
        command = 'Catppuccin mocha',
      })
    end,
  },
}
