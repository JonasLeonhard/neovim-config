return {
  'ThePrimeagen/harpoon',
  lazy = true,
  keys = {
    {
      '<leader>m,',
      "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
      desc = 'Harpoon (key: ",")',
    },
    {
      ',,',
      "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
      desc = 'Marks (builtin)',
    },
    {
      ',a',
      "<cmd>lua require('harpoon.mark').add_file()<cr>",
      desc = 'Add File Mark',
    },
    {
      ',d',
      "<cmd>lua require('harpoon.mark').toggle_file()<cr>",
      desc = 'Toggle File Mark',
    },
    {
      ',n',
      "<cmd>lua require('harpoon.ui').nav_next()<cr>",
      desc = 'Next Mark',
    },
    {
      ',b',
      "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
      desc = 'Prev Mark',
    },
    {
      ',1',
      "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
      desc = 'Navigate to Harpoon Mark (1)',
    },
    {
      ',2',
      "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
      desc = 'Navigate to Harpoon Mark (2)',
    },
    {
      ',3',
      "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
      desc = 'Navigate to Harpoon Mark (3)',
    },
    {
      ',4',
      "lua require('harpoon.ui').nav_file(4)<cr>",
      desc = 'Navigate to Harpoon Mark (4)',
    },
    {
      ',5',
      "<cmd>lua require('harpoon.ui').nav_file(5)<cr>",
      desc = 'Navigate to Harpoon Mark (5)',
    },
  },
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 12,
    }
  }
}
