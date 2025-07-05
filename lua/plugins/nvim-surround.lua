return {
  pack = {
    src = "https://github.com/kylechui/nvim-surround",
  },
  lazy = {
    "nvim-surround",
    event = "DeferredUIEnter",
    after = function()
      require("nvim-surround").setup({
        keymaps = {
          insert = nil,
          insert_line = nil,
          normal = nil,
          normal_cur = nil,
          normal_line = nil,
          normal_cur_line = nil,
          visual = "s",
          visual_line = nil,
          delete = "ds",
          change = "cs",
          change_line = nil,
        },
      })
    end
  }

}
