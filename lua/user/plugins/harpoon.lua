return {
  'ThePrimeagen/harpoon',
  event = 'VeryLazy',
  lazy = true,
  config = function()
    require('harpoon').setup()
  end,
}
