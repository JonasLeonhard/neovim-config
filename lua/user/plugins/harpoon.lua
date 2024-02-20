return {
  'ThePrimeagen/harpoon',
  lazy = true,
  keys = {
    {
      '<leader>mm',
      "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
      desc = 'Marks (builtin)',
    },
    {
      '<leader>ma',
      "<cmd>lua require('harpoon.mark').add_file()<cr>",
      desc = 'Add File Mark',
    },
    {
      '<leader>md',
      "<cmd>lua require('harpoon.mark').toggle_file()<cr>",
      desc = 'Toggle File Mark',
    },
    {
      '<leader>mn',
      "<cmd>lua require('harpoon.ui').nav_next()<cr>",
      desc = 'Next Mark',
    },
    {
      '<leader>mb',
      "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
      desc = 'Prev Mark',
    },
    {
      '<leader>m1',
      "<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
      desc = 'Navigate to Harpoon Mark (1)',
    },
    {
      '<leader>m2',
      "<cmd>lua require('harpoon.ui').nav_file(2)<cr>",
      desc = 'Navigate to Harpoon Mark (2)',
    },
    {
      '<leader>m3',
      "<cmd>lua require('harpoon.ui').nav_file(3)<cr>",
      desc = 'Navigate to Harpoon Mark (3)',
    },
    {
      '<leader>m4',
      "lua require('harpoon.ui').nav_file(4)<cr>",
      desc = 'Navigate to Harpoon Mark (4)',
    },
    {
      '<leader>m5',
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
