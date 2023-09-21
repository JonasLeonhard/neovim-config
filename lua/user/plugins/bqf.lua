return {
  'kevinhwang91/nvim-bqf',
  lazy = true,
  dependencies = { 'nvim-telescope/telescope.nvim' },
  ft = 'qf',
  keys = {
    {
      'zf',
      function()
        require('telescope.builtin').quickfix()
      end,
      desc = 'Quickfix filter',
    },
  },
  opts = {
    -- disable qf window
    preview = {
      border = 'none',
    },
    func_map = {
      fzffilter = 'zF',
    },
  },
}
