return {
  'echasnovski/mini.indentscope',
  version = false,
  event = 'VeryLazy',
  lazy = true,
  opts = {
    symbol = '┊',
    options = { try_as_border = true },
    draw = {
      delay = 100,
      animation = function()
        return 0
      end,
    },
  },
}
