return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require 'telescope'
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#181825' })
      telescope.setup {
        defaults = require('telescope.themes').get_ivy {
          border = false,
        },
      }
      telescope.load_extension 'fzf'
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
}
