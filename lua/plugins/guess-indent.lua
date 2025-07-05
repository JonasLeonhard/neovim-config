return {
  pack = {
    src = 'https://github.com/nmac427/guess-indent.nvim',
  },
  lazy = {
    "guess-indent.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("guess-indent").setup({
        auto_cmd = true
      })
    end
  }
}
