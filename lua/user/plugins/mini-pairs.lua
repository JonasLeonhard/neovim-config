return {
  'echasnovski/mini.pairs',
  event = 'VeryLazy',
  lazy = true,
  config = function(_, opts)
    require('mini.pairs').setup(opts)
  end,
}
