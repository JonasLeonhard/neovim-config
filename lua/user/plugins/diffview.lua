return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  event = 'VeryLazy',
  lazy = true,
  config = function()
    local actions = require 'diffview.actions'
    require('diffview').setup {
      enhanced_diff_hl = true,
      keymaps = {
        disable_defaults = true,
        view = {
          -- rest in wichkey bindings
          q = '<Cmd>DiffviewClose<CR>',
        },
        file_panel = {
          q = '<Cmd>DiffviewClose<CR>',
          { 'n', 'j', actions.next_entry, { desc = 'Bring the cursor to the next file entry' } },
          { 'n', '<down>', actions.next_entry, { desc = 'Bring the cursor to the next file entry' } },
          { 'n', 'k', actions.prev_entry, { desc = 'Bring the cursor to the previous file entry' } },
          { 'n', '<up>', actions.prev_entry, { desc = 'Bring the cursor to the previous file entry' } },
          { 'n', '<cr>', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          { 'n', 'o', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          { 'n', 'l', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          { 'n', '<2-LeftMouse>', actions.select_entry, { desc = 'Open the diff for the selected entry' } },
          { 'n', '-', actions.toggle_stage_entry, { desc = 'Stage / unstage the selected entry' } },
          { 'n', 'S', actions.stage_all, { desc = 'Stage all entries' } },
          { 'n', 'U', actions.unstage_all, { desc = 'Unstage all entries' } },
          { 'n', 'X', actions.restore_entry, { desc = 'Restore entry to the state on the left side' } },
          { 'n', 'L', actions.open_commit_log, { desc = 'Open the commit log panel' } },
          { 'n', 'zo', actions.open_fold, { desc = 'Expand fold' } },
          { 'n', 'h', actions.close_fold, { desc = 'Collapse fold' } },
          { 'n', 'zc', actions.close_fold, { desc = 'Collapse fold' } },
          { 'n', 'za', actions.toggle_fold, { desc = 'Toggle fold' } },
          { 'n', 'zR', actions.open_all_folds, { desc = 'Expand all folds' } },
          { 'n', 'zM', actions.close_all_folds, { desc = 'Collapse all folds' } },
          { 'n', '<c-b>', actions.scroll_view(-0.25), { desc = 'Scroll the view up' } },
          { 'n', '<c-f>', actions.scroll_view(0.25), { desc = 'Scroll the view down' } },
          { 'n', '<tab>', actions.select_next_entry, { desc = 'Open the diff for the next file' } },
          { 'n', '<s-tab>', actions.select_prev_entry, { desc = 'Open the diff for the previous file' } },
          { 'n', 'gf', actions.goto_file_edit, { desc = 'Open the file in the previous tabpage' } },
          { 'n', '<C-w><C-f>', actions.goto_file_split, { desc = 'Open the file in a new split' } },
          { 'n', '<C-w>gf', actions.goto_file_tab, { desc = 'Open the file in a new tabpage' } },
          { 'n', 'i', actions.listing_style, { desc = "Toggle between 'list' and 'tree' views" } },
          {
            'n',
            'f',
            actions.toggle_flatten_dirs,
            { desc = 'Flatten empty subdirectories in tree listing style' },
          },
          { 'n', '<leader>e', actions.focus_files, { desc = 'Bring focus to the file panel' } },
          { 'n', '<leader>b', actions.toggle_files, { desc = 'Toggle the file panel' } },
          { 'n', 'g<C-x>', actions.cycle_layout, { desc = 'Cycle available layouts' } },
          { 'n', 'g?', actions.help 'file_panel', { desc = 'Open the help panel' } },
        },
        file_history_panel = {
          q = '<Cmd>DiffviewClose<CR>',
          { 'n', 'g!', actions.options, { desc = 'Open the option panel' } },
          { 'n', '<C-A-d>', actions.open_in_diffview, {
            desc = 'Open the entry under the cursor in a diffview',
          } },
          { 'n', 'y', actions.copy_hash, {
            desc = 'Copy the commit hash of the entry under the cursor',
          } },
          { 'n', 'L', actions.open_commit_log, { desc = 'Show commit details' } },
          { 'n', 'zR', actions.open_all_folds, { desc = 'Expand all folds' } },
          { 'n', 'zM', actions.close_all_folds, { desc = 'Collapse all folds' } },
          { 'n', 'j', actions.next_entry, { desc = 'Bring the cursor to the next file entry' } },
          { 'n', '<down>', actions.next_entry, { desc = 'Bring the cursor to the next file entry' } },
          { 'n', 'k', actions.prev_entry, {
            desc = 'Bring the cursor to the previous file entry.',
          } },
          { 'n', '<up>', actions.prev_entry, {
            desc = 'Bring the cursor to the previous file entry.',
          } },
          { 'n', '<cr>', actions.select_entry, { desc = 'Open the diff for the selected entry.' } },
          { 'n', 'o', actions.select_entry, { desc = 'Open the diff for the selected entry.' } },
          { 'n', '<2-LeftMouse>', actions.select_entry, { desc = 'Open the diff for the selected entry.' } },
          { 'n', '<c-b>', actions.scroll_view(-0.25), { desc = 'Scroll the view up' } },
          { 'n', '<c-f>', actions.scroll_view(0.25), { desc = 'Scroll the view down' } },
          { 'n', '<tab>', actions.select_next_entry, { desc = 'Open the diff for the next file' } },
          { 'n', '<s-tab>', actions.select_prev_entry, { desc = 'Open the diff for the previous file' } },
          { 'n', 'gf', actions.goto_file_edit, { desc = 'Open the file in the previous tabpage' } },
          { 'n', '<C-w><C-f>', actions.goto_file_split, { desc = 'Open the file in a new split' } },
          { 'n', '<C-w>gf', actions.goto_file_tab, { desc = 'Open the file in a new tabpage' } },
          { 'n', '<leader>e', actions.focus_files, { desc = 'Bring focus to the file panel' } },
          { 'n', '<leader>b', actions.toggle_files, { desc = 'Toggle the file panel' } },
          { 'n', 'g<C-x>', actions.cycle_layout, { desc = 'Cycle available layouts' } },
          { 'n', 'g?', actions.help 'file_history_panel', { desc = 'Open the help panel' } },
        },
        option_panel = {
          { 'n', '<tab>', actions.select_entry, { desc = 'Change the current option' } },
          { 'n', 'q', actions.close, { desc = 'Close the panel' } },
          { 'n', 'g?', actions.help 'option_panel', { desc = 'Open the help panel' } },
        },
        help_panel = {
          { 'n', 'q', actions.close, { desc = 'Close help menu' } },
          { 'n', '<esc>', actions.close, { desc = 'Close help menu' } },
        },
      },
      view = {
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = 'diff3_mixed',
          disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
          winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
        },
      },
    }

    vim.cmd 'highlight DiffviewDiffAddAsDelete guibg=#11111b guifg=0'
  end,
}
