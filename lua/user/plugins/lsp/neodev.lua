return {
  'folke/neodev.nvim',
  lazy = true,
  event = 'User FileOpened',
  config = function()
    require('neodev').setup()
  end,
}
