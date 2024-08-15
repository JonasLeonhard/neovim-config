return {
  'LeonHeidelbach/trailblazer.nvim',
  lazy = true,
  keys = {
    {
      'gm',
      '<cmd>lua require("trailblazer").new_trail_mark()<cr>',
      mode = { 'v', 'n' },
      desc = 'New trailblazer',
    },
    {
      'gh',
      '<cmd>lua require("trailblazer").track_back()<cr>',
      mode = { 'v', 'n' },
      desc = 'Trailblazer track back',
    },
    {
      'gk',
      '<cmd>lua require("trailblazer").peek_move_next_down()<cr>',
      mode = { 'v', 'n' },
      desc = 'Peek trailblazer downwards',
    },
    {
      'gj',
      '<cmd>lua require("trailblazer").peek_move_previous_up()<cr>',
      mode = { 'v', 'n' },
      desc = 'Peek trailblazer upwards',
    },
    {
      'gl',
      '<cmd>lua require("trailblazer").move_to_nearest()<cr>',
      mode = { 'v', 'n' },
      desc = 'Move to nearest trailblazer',
    },
    {
      'g1',
      function()
        local common = require 'trailblazer.trails.common'
        common.focus_win_and_buf_by_trail_mark_index(nil, 1, false)
      end,
      desc = 'Trailblazer at pos 1',
    },
    {
      'g2',
      function()
        local common = require 'trailblazer.trails.common'
        common.focus_win_and_buf_by_trail_mark_index(nil, 2, false)
      end,
      desc = 'Trailblazer at pos 2',
    },
    {
      'g3',
      function()
        local common = require 'trailblazer.trails.common'
        common.focus_win_and_buf_by_trail_mark_index(nil, 3, false)
      end,
      desc = 'Trailblazer at pos 3',
    },
    {
      'g4',
      function()
        local common = require 'trailblazer.trails.common'
        common.focus_win_and_buf_by_trail_mark_index(nil, 4, false)
      end,
      desc = 'Trailblazer at pos 4',
    },
    {
      'g5',
      function()
        local common = require 'trailblazer.trails.common'
        common.focus_win_and_buf_by_trail_mark_index(nil, 5, false)
      end,
      desc = 'Trailblazer at pos 5',
    },
    {
      'g6',
      function()
        local common = require 'trailblazer.trails.common'
        common.focus_win_and_buf_by_trail_mark_index(nil, 6, false)
      end,
      desc = 'Trailblazer at pos 6',
    },
    {
      'g7',
      function()
        local common = require 'trailblazer.trails.common'
        common.focus_win_and_buf_by_trail_mark_index(nil, 7, false)
      end,
      desc = 'Trailblazer at pos 7',
    },
    {
      'g8',
      function()
        local common = require 'trailblazer.trails.common'
        common.focus_win_and_buf_by_trail_mark_index(nil, 8, false)
      end,
      desc = 'Trailblazer at pos 8',
    },
    {
      'g9',
      function()
        local common = require 'trailblazer.trails.common'
        common.focus_win_and_buf_by_trail_mark_index(nil, 9, false)
      end,
      desc = 'Trailblazer at pos 9',
    },
    {
      '<leader>mm',
      '<cmd>lua require("trailblazer").toggle_trail_mark_list()<cr>',
      mode = { 'v', 'n' },
      desc = 'Toggle Trailblazer List',
    },
    {
      '<leader>md',
      '<cmd>lua require("trailblazer").delete_all_trail_marks()<cr>',
      mode = { 'v', 'n' },
      desc = 'Delet all Trailblazers',
    },
    {
      '<leader>mj',
      '<cmd>lua require("trailblazer").switch_to_next_trail_mark_stack()<cr>',
      mode = { 'v', 'n' },
      desc = 'Goto prev Trailblazer Stack',
    },
    {
      '<leader>mk',
      '<cmd>lua require("trailblazer").switch_to_previous_trail_mark_stack()<cr>',
      mode = { 'v', 'n' },
      desc = 'Goto next Trailblazer Stack',
    },
    {
      '<leader>mn',
      function()
        local stackname = vim.fn.input 'Create Trailblazer Stack: '
        vim.cmd { cmd = 'TrailBlazerAddTrailMarkStack', args = { stackname } }
      end,
      mode = { 'v', 'n' },
      desc = 'Create new Trailblazer Stack',
    },
    {
      '<leader>mD',
      function()
        local stackname = vim.fn.input 'Delete Trailblazer Stack: '
        vim.cmd { cmd = 'TrailBlazerDeleteTrailMarkStack', args = { stackname } }
      end,
      mode = { 'v', 'n' },
      desc = 'Delete Trailblazer Stack',
    },
  },
  opts = {
    trail_options = {
      mark_symbol = '•', --  will only be used if trail_mark_symbol_line_indicators_enabled = true
      newest_mark_symbol = '󱄂', -- disable this mark symbol by setting its value to ""
      cursor_mark_symbol = '󱄂', -- disable this mark symbol by setting its value to ""
      next_mark_symbol = '󱋜', -- disable this mark symbol by setting its value to ""
      previous_mark_symbol = '󱋛', -- disable this mark symbol by setting its value to ""
    },
    -- unset all, we use keys for lazyloading and which-key desc...
    force_mappings = {
      nv = {
        motions = {},
        actions = {},
      },
    },
  },
}
