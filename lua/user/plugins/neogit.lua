return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
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
