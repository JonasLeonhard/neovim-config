--- global buffer_id list, used for swapping buffers.
--- since you cannot swap buffers in vim.api.nvim_list_bufs() directly we store them temporarily
local bufnrs_with_swap = {}

local get_bufnrs_with_swap = function()
  -- get all listed bufs
  local bufnrs = vim.tbl_filter(function(bufnr)
    if 1 ~= vim.fn.buflisted(bufnr) then
      return false
    end

    return true
  end, vim.api.nvim_list_bufs())

  -- update bufnrs_with_swap
  for _, bufnr in ipairs(bufnrs) do
    -- add all newly created buffers to end of swaplist
    if not vim.tbl_contains(bufnrs_with_swap, bufnr) then
      table.insert(bufnrs_with_swap, bufnr)
    end
  end

  for i, bufnr in ipairs(bufnrs_with_swap) do
    -- remove all buffers that are not listed anymore
    if not vim.tbl_contains(bufnrs, bufnr) then
      table.remove(bufnrs_with_swap, i)
    end
  end

  return bufnrs_with_swap
end

return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    enabled = false,
    branch = 'master',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
        build = 'make',
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
        '<leader>bl',
        function()
          -- define a custom picker for buffers with extended functionality.
          -- if you dont need this. Take a look at ':h telescope.builtin.buffers()'
          -- 1. +delete buffers with 'd'
          -- 2. +select buffer with 'v'
          -- 3. +close picker with <C-l>
          -- 4. +Change buffer order with <C-j> and <C-k>

          local opts = {}
          local pickers = require 'telescope.pickers'
          local finders = require 'telescope.finders'
          local conf = require('telescope.config').values
          local make_entry = require 'telescope.make_entry'
          local action_state = require 'telescope.actions.state'
          local actions = require 'telescope.actions'
          local default_selection_idx = 1

          local swap = function(bufnr, adj_bufnr)
            local idx_bufnr = nil
            local idx_adj_bufnr = nil

            for i, buf in ipairs(bufnrs_with_swap) do
              if buf == bufnr then
                idx_bufnr = i
              end
              if buf == adj_bufnr then
                idx_adj_bufnr = i
              end
            end

            if idx_bufnr and idx_adj_bufnr then
              bufnrs_with_swap[idx_bufnr], bufnrs_with_swap[idx_adj_bufnr] = bufnrs_with_swap[idx_adj_bufnr],
                  bufnrs_with_swap[idx_bufnr]
            end
          end

          -- only display listed buffers
          local bufnrs = get_bufnrs_with_swap()

          -- create buffers
          local create_finder_from_swap = function()
            local buffers = {}
            for i, bufnr in ipairs(bufnrs) do
              local flag = bufnr == vim.fn.bufnr '' and '%' or (bufnr == vim.fn.bufnr '#' and '#' or ' ')
              local element = {
                bufnr = bufnr,
                flag = flag,
                info = vim.fn.getbufinfo(bufnr)[1],
              }
              if flag == '%' then
                default_selection_idx = i
              end
              table.insert(buffers, element)
            end
            return finders.new_table {
              results = buffers,
              entry_maker = make_entry.gen_from_buffer(opts),
            }
          end

          if not opts.bufnr_width then
            local max_bufnr = math.max(unpack(bufnrs))
            opts.bufnr_width = #tostring(max_bufnr)
          end

          pickers
              .new(opts, {
                initial_mode = 'normal',
                prompt_title = 'Buffers',
                finder = create_finder_from_swap(),
                previewer = conf.grep_previewer(opts),
                sorter = conf.generic_sorter(opts),
                default_selection_index = default_selection_idx,

                attach_mappings = function(prompt_bufnr, map)
                  local delete_buf = function()
                    local current_picker = action_state.get_current_picker(prompt_bufnr)
                    current_picker:delete_selection(function(selection)
                      vim.api.nvim_buf_delete(selection.bufnr, { force = true })
                    end)
                  end

                  map('n', 'v', function()
                    actions.add_selection(prompt_bufnr)
                  end)
                  map('n', 'd', delete_buf)
                  map('i', '<C-l>', actions.close)
                  map('n', '<C-l>', actions.close)

                  --- @param up boolean: if true, move the buffer up
                  local buffer_swap = function(up)
                    local hovered_buffer = action_state.get_selected_entry()
                    local picker = action_state.get_current_picker(prompt_bufnr)
                    local picker_results = picker.finder.results

                    for i, entry in ipairs(picker_results) do
                      -- Find the hovered buffer in the picker results
                      if entry.bufnr == hovered_buffer.bufnr then
                        -- pick the adjacent entry and wrap around the ends
                        local adj_entry
                        local new_index

                        if up then
                          new_index = (i % #picker_results) + 1
                        else
                          if i - 1 < 1 then
                            new_index = #picker_results
                          else
                            new_index = i - 1
                          end
                        end

                        adj_entry = picker_results[new_index]

                        -- Swap the hovered buffer with the adjacent buffer based on direction (up)
                        if adj_entry and adj_entry.bufnr ~= entry.bufnr then
                          swap(entry.bufnr, adj_entry.bufnr)
                          picker.default_selection_index = new_index
                          picker:refresh(create_finder_from_swap(), opts)
                          break
                        end
                      end
                    end
                  end

                  -- -- Mapping to swap buffer positions
                  map('n', '<C-j>', function()
                    buffer_swap(false)
                  end)
                  map('n', '<C-k>', function()
                    buffer_swap(true)
                  end)

                  return true
                end,
              })
              :find()
        end,
        desc = 'Buffers',
      },
      {
        '<leader>bj',
        -- alternative to '<cmd>bnext<cr>', but using swaplist
        function()
          local bufnrs = get_bufnrs_with_swap()
          local current_bufnr = vim.fn.bufnr '%'

          for i, bufnr in ipairs(bufnrs) do
            if bufnr == current_bufnr then
              vim.cmd('buffer ' .. bufnrs[i % #bufnrs + 1])
              break
            end
          end
        end,
        desc = 'buffer next',
      },
      {
        '<leader>bk',
        -- alternative to '<cmd>bprevious<cr>', but using swaplist
        function()
          local bufnrs = get_bufnrs_with_swap()
          local current_bufnr = vim.fn.bufnr '%'

          for i, bufnr in ipairs(bufnrs) do
            if bufnr == current_bufnr then
              vim.cmd('buffer ' .. bufnrs[(i - 2) % #bufnrs + 1])
              break
            end
          end
        end,
        desc = 'buffer prev',
      },
    },
    config = function()
      local telescope = require 'telescope'
      local actions = require 'telescope.actions'

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
          mappings = {
            n = {
              ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
            },
            i = {
              -- map actions.which_key to <C-h> (default: <C-/>)
              -- actions.which_key shows the mappings for your picker,
              -- e.g. git_{create, delete, ...}_branch for the git_branches picker
              ['<C-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
            },
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
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = 'smart_case',       -- or "ignore_case" or "respect_case"
          },
        },
      }
      telescope.load_extension 'fzf'

      vim.keymap.set('n', '<C-e>', function() end)
    end,
  },
}
