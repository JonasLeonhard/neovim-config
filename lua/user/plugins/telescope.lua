return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-fzf-native.nvim' },
    event = 'VeryLazy',
    lazy = true,
    config = function()
      local telescope = require 'telescope'
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = '#181825' })
      telescope.setup {
        defaults = {
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
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          },
        },
      }
      telescope.load_extension 'fzf'
    end,
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    lazy = true,
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },
}
