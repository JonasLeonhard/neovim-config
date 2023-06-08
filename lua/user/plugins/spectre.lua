return {
  'windwp/nvim-spectre',
  event = 'VeryLazy',
  lazy = true,
  config = function()
    require('spectre').setup()
  end,
}
