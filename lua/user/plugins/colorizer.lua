return {
  'norcalli/nvim-colorizer.lua',
  event = 'VeryLazy',
  lazy = true,
  config = function()
    require('colorizer').setup()
  end,
}
