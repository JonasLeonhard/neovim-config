return {
  -- Adds git releated signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  lazy = true,
  opts = {},
  keys = {
    {
      '<leader>g]',
      function()
        if vim.wo.diff then
          return ']c'
        end
        vim.schedule(function()
          require('gitsigns').next_hunk()
        end)
        return '<Ignore>'
      end,
      desc = 'Jump to next hunk',
    },
    {
      '<leader>g[',
      function()
        if vim.wo.diff then
          return '{c'
        end
        vim.schedule(function()
          require('gitsigns').prev_hunk()
        end)
        return '<Ignore>'
      end,
      desc = 'Jump to prev hunk',
    },
    {
      '<leader>gr',
      function()
        require('gitsigns').reset_hunk()
      end,
      desc = 'Reset hunk',
    },
    {
      '<leader>gh',
      function()
        require('gitsigns').preview_hunk()
      end,
      desc = 'Preview hunk',
    },
    {
      '<leader>gb',
      function()
        require('gitsigns').blame_line { full = true }
      end,
      desc = 'Blame line',
    },
    {
      '<leader>gB',
      function()
        require('gitsigns').blame();
      end,
      desc = 'Blame Menu',
    },
    {
      '<leader>ugd',
      function()
        require('gitsigns').toggle_deleted()
      end,
      desc = 'GitSigns Toggle deleted',
    },
    {
      '<leader>ugd',
      function()
        require('gitsigns').toggle_deleted()
      end,
      desc = 'GitSigns Toggle deleted',
    },
    {
      '<leader>sS',
      '<cmd>Gitsigns setqflist<cr>',
      desc = 'GitSigns qflist',
    },
    {
      '[S',
      '<cmd>Gitsigns prev_hunk<cr>',
      desc = 'GitSigns prev_hunk',
    },
    {
      ']S',
      '<cmd>Gitsigns next_hunk<cr>',
      desc = 'GitSigns next_hunk',
    },
  },
}
