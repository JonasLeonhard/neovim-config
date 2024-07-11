return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
        build = 'make',
      },
      'nvim-telescope/telescope-ui-select.nvim',
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
        desc = '󰈞 Find files (git)',
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
        '<leader>sG',
        function()
          require('telescope.builtin').live_grep { search_dirs = { vim.fn.expand '%:h' } }
        end,
        desc = 'Grep from current file dir',
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
      {
        '<leader>sm',
        '<cmd>Telescope marks<cr>',
        desc = 'Find Marks',
      },
      {
        '<C-l>',
        function()
          local builtin = require 'telescope.builtin'
          local action_state = require 'telescope.actions.state'
          local actions = require 'telescope.actions'

          builtin.buffers {
            sort_lastused = true,
            sort_mru = true,
            initial_mode = 'insert',
            attach_mappings = function(prompt_bufnr, map)
              local delete_buf = function()
                local current_picker = action_state.get_current_picker(prompt_bufnr)
                current_picker:delete_selection(function(selection)
                  vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                end)
              end

              map('n', 'd', delete_buf)
              map('i', '<C-l>', actions.close)

              return true
            end,
          }
        end,
        desc = 'Buffers',
      },
      {
        'gk',
        '<cmd>bnext<cr>',
        desc = 'buffer next',
      },
      {
        'gj',
        '<cmd>bprevious<cr>',
        desc = 'buffer prev',
      },
    },
    config = function()
      local telescope = require 'telescope'

      telescope.setup {
        defaults = {
          sorting_strategy = 'descending',
          layout_strategy = 'bottom_pane',
          layout_config = {
            prompt_position = 'bottom',
            height = 25,
          },
          border = true,
          borderchars = { '─', '', '', '', '', '', '', '' }, -- only top border
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
      telescope.load_extension 'ui-select'

      vim.keymap.set('n', '<C-e>', function() end)

      vim.api.nvim_create_user_command('ProfileStart', function()
        require('plenary.profile').start(('profile-%s.log'):format(vim.version()), { flame = true })
      end, {})

      vim.api.nvim_create_user_command('ProfileStop', require('plenary.profile').stop, {})
    end,
  },
}
