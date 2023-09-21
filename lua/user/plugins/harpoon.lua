return {
  'ThePrimeagen/harpoon',
  lazy = true,
  keys = {
    { '<leader>ml', '<cmd>Telescope harpoon marks<cr>', desc = 'list Marks' },
    {
      '<leader>mm',
      function()
        require('harpoon.ui').toggle_quick_menu()
      end,
      desc = 'Marks (builtin)',
    },
    {
      '<leader>ma',
      function()
        require('harpoon.mark').add_file()
      end,
      desc = 'Add File Mark',
    },
    {
      '<leader>md',
      function()
        require('harpoon.mark').toggle_file()
      end,
      desc = 'Toggle File Mark',
    },
    {
      '<leader>mn',
      function()
        require('harpoon.ui').nav_next()
      end,
      desc = 'Next Mark',
    },
    {
      '<leader>mb',
      function()
        require('harpoon.ui').nav_prev()
      end,
      desc = 'Prev Mark',
    },
    {
      '<leader>m1',
      function()
        require('harpoon.ui').nav_file(1)
      end,
      desc = 'Navigate to Harpoon Mark (1)',
    },
    {
      '<leader>m2',
      function()
        require('harpoon.ui').nav_file(2)
      end,
      desc = 'Navigate to Harpoon Mark (2)',
    },
    {
      '<leader>m3',
      function()
        require('harpoon.ui').nav_file(3)
      end,
      desc = 'Navigate to Harpoon Mark (3)',
    },
    {
      '<leader>m4',
      function()
        require('harpoon.ui').nav_file(4)
      end,
      desc = 'Navigate to Harpoon Mark (4)',
    },
    {
      '<leader>m5',
      function()
        require('harpoon.ui').nav_file(5)
      end,
      desc = 'Navigate to Harpoon Mark (5)',
    },
  },
}
