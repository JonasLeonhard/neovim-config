return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  opts = {
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
  }
}
