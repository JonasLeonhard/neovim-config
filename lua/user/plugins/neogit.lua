return {
  'NeogitOrg/neogit',
  dependencies = 'nvim-lua/plenary.nvim',
  config = {
    signs = {
      -- { CLOSED, OPENED }
      section = { '-', '+' },
      item = { '', ' ' },
      hunk = { '', '' },
    },
  },
  lazy = true,
  keys = {
    {
      '<leader>gg',
      function()
        require('neogit').open()
      end,
      desc = 'Neogit',
    },
  },
}
