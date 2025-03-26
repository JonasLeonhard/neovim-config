return {
  'stevearc/quicker.nvim',
  lazy = true,
  ft = 'qf',
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {
    opts = {
      relativenumber = true,
    },
    keys = {
      {
        '<TAB>',
        function()
          require('quicker').expand { before = 2, after = 2, add_to_existing = true }
        end,
        desc = 'Expand quickfix context',
      },
      {
        '<S-TAB>',
        function()
          require('quicker').collapse()
        end,
        desc = 'Collapse quickfix context',
      },
    },
  },
  keys = {
    {
      '<leader>uq',
      function()
        require('quicker').toggle { focus = true }
      end,
      desc = 'Toggle Quicker',
      mode = 'n',
    },
    {
      'gq',
      '<cmd>:cnext<cr>',
      desc = 'cnext (Quickfix)',
    },
    {
      'gQ',
      '<cmd>:cprevious<cr>',
      desc = 'cprevious (Quickfix)',
    },
  },
}
