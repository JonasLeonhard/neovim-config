return {
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    lazy = true,
    opts = { delay = 200 },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
  },
}
