return {
  pack = {
    src = 'https://github.com/echasnovski/mini.pairs',
  },
  lazy = {
    "mini.pairs",
    event = "DeferredUIEnter",
    after = function()
      require("mini.pairs").setup({});
    end
  }
}
