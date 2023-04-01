return {
  'windwp/nvim-spectre',
  event = 'VeryLazy',
  config = function()
    require('spectre').setup()
  end,
}
