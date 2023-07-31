return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        lazy = true,
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
    lazy = true,
    keys = {
      {
        '<leader>bb',
        function()
          require('telescope.builtin').buffers()
        end,
        desc = 'Find existing buffers',
      },
      {
        '<leader>cs',
        function()
          require('telescope.builtin').lsp_document_symbols()
        end,
        desc = 'Document Symbols',
      },
      {
        'gr',
        function()
          require('telescope.builtin').lsp_references()
        end,
        desc = 'Goto References',
      },
      {
        '<leader>cws',
        function()
          require('telescope.builtin').lsp_dynamic_workspace_symbols()
        end,
        desc = 'Workspace Symbols',
      },
      {
        '<leader>f',
        '<cmd>Telescope git_files<cr>',
        desc = 'Find files (git)',
      },
      {
        '<leader>s?',
        '<cmd>Telescope<cr>',
        desc = 'Select a Picker',
      },
      {
        '<leader>sr',
        function()
          require('telescope.builtin').oldfiles()
        end,
        desc = 'Find recently opened files',
      },
      {
        '<leader>sR',
        function()
          require('telescope.builtin').resume()
        end,
        desc = 'Resume last picker',
      },
      {
        '<leader>sh',
        function()
          require('telescope.builtin').help_tags()
        end,
        desc = 'Help',
      },
      {
        '<leader>sw',
        function()
          require('telescope.builtin').grep_string()
        end,
        desc = 'Cursor Word',
      },
      {
        '<leader>sg',
        function()
          require('telescope.builtin').live_grep()
        end,
        desc = 'Grep',
      },
      {
        '<leader>sd',
        function()
          require('telescope.builtin').diagnostics()
        end,
        desc = 'Diagnostics',
      },
      {
        '<leader>sf',
        '<cmd>Telescope find_files<cr>',
        desc = 'Find files (all)',
      },
    },
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
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
          },
        },
      }
      telescope.load_extension 'fzf'
    end,
  },
}
