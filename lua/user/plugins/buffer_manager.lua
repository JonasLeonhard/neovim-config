return {
  'https://github.com/JonasLeonhard/buffer_manager.nvim',
  lazy = true,
  opts = {
    width = vim.o.columns,
    height = math.floor(vim.api.nvim_win_get_height(0) / 2),
    borderchars = { "─", " ", " ", " ", " ", " ", " ", " " },
  },
  keys = {
    {
      'gk',
      function()
        require("buffer_manager.ui").nav_next()
      end,
      desc = 'next buffer',
      mode = 'n'
    },
    {
      'gj',
      function()
        require("buffer_manager.ui").nav_prev()
      end,
      desc = 'previous buffer',
      mode = 'n'
    },
    {
      '<C-l>',
      function()
        require("buffer_manager.ui").toggle_quick_menu()
      end,
      desc = 'quick menu',
      mode = 'n'
    },
    {
      '<leader>bs',
      function()
        require 'buffer_manager.ui'.save_menu_to_file()
      end,
      desc = 'save menu to file'
    },
    {
      '<leader>bS',
      function()
        require 'buffer_manager.ui'.load_menu_from_file()
      end,
      desc = 'save menu to file'
    }
  }
}
