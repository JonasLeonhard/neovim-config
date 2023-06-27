return {
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = 'User FileOpened',
    lazy = true,
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
      show_current_context = true,
    },
    config = function(_, opts)
      vim.cmd [[highlight IndentBlanklineContextChar guifg=#585B70 gui=nocombine]]
      require('indent_blankline').setup(opts)
    end,
  },
}
