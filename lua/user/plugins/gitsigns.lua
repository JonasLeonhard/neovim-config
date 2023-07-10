return {
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = 'User FileOpened',
    lazy = true,
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    dependencies = { 'petertriho/nvim-scrollbar' },
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
          require('gitsigns').blame_line()
        end,
        desc = 'Blame line',
      },
      {
        '<leader>ugd',
        function()
          require('gitsigns').toggle_deleted()
        end,
        desc = 'GitSigns Toggle deleted',
      }
    },
    config = function()
      require('gitsigns').setup()
      require('scrollbar.handlers.gitsigns').setup()
    end,
  },
}
