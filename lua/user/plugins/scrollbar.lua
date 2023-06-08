return {
  'petertriho/nvim-scrollbar',
  event = 'VeryLazy',
  lazy = true,
  config = function()
    require('scrollbar').setup()
  end,
}
