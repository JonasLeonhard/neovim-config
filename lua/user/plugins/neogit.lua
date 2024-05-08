return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  branch = "nightly",
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    signs = {
      -- { CLOSED, OPENED }
      section = { '-', '+' },
      item = { '', ' ' },
      hunk = { '', '' },
    },
    commit_editor = {
      kind = "vsplit",
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
