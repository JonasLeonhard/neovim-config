return {
  'echasnovski/mini.indentscope',
  version = false,
  event = 'User FileOpened',
  lazy = true,
  opts = {
    symbol = '┊',
    options = { try_as_border = true },
    draw = {
      animation = function() return 0 end,
    }
  },
  init = function()
    vim.cmd.highlight("default link MiniIndentscopeSymbol Comment")
  end
}
