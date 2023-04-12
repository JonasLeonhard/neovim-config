return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local telescope = require 'telescope'
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#181825' })
      telescope.setup {
        defaults = {
          theme = 'ivy',
          sorting_strategy = 'ascending',
          layout_strategy = 'bottom_pane',
          layout_config = {
            height = 25,
          },
          border = false,
          file_ignore_patterns = {
            'node_modules/',
            '.git/',
            'vendor/',
            'dist/',
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            no_ignore = true, -- include gitignore files
          },
          live_grep = {
            only_sort_text = true, -- don't include the filename in the search results
          },
          grep_string = {
            only_sort_text = true,
          },
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
