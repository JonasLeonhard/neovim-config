return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  dependencies = 'nvim-lua/plenary.nvim',
  branch = "nightly",
  opts = {
    signs = {
      -- { CLOSED, OPENED }
      section = { '-', '+' },
      item = { '', ' ' },
      hunk = { '', '' },
    },
  },
  lazy = true,
  event = "VeryLazy",
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
