return {
  pack = {
    src = 'https://github.com/echasnovski/mini.icons',
  },
  lazy = {
    "mini.icons",
    event = "DeferredUIEnter",
    after = function()
      require('mini.icons').setup()
    end
  }
}
