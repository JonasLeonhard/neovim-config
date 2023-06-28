return {
  'folke/neodev.nvim',
  lazy = true,
  event = 'User File Opened',
  config = function()
    require('neodev').setup()
  end,
}
