return {
  'norcalli/nvim-colorizer.lua',
  event = 'User FileOpened',
  lazy = true,
  config = function()
    require('colorizer').setup()
  end,
}
