return {
  'folke/neodev.nvim',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    require('neodev').setup()
  end,
}
