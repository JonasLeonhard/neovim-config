return {
  'L3MON4D3/LuaSnip',
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = function()
    local luasnip = require 'luasnip'
    require('luasnip.loaders.from_vscode').lazy_load() -- loads friendly-snippets
    require('luasnip.loaders.from_vscode').lazy_load { paths = { './lua/user/plugins/snippets/' } } -- loads snippets in user/plugins/snippets/[filetype].snippets
    luasnip.config.setup {}
  end,
  event = 'VeryLazy',
  lazy = true,
}
