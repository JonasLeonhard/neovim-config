-- TODO: make this responsive.
local function getMarginRight()
  local winWidth = vim.fn.winwidth(0);
  if winWidth <= 160 then
    return 0
  end

  return math.floor(winWidth * 0.6)
end

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      window = {
        margin = { 1, getMarginRight(), 1, 0 }, -- extra window margin [top, right, bottom, left]
      },
      show_help = false
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- TODO: think about keybinds here
      local keymaps = {
        mode = { "n", "v" },
        ["g"] = { name = "goto",
          ["j"] = { "<cmd>BufferLineCycleNext<cr>", "next buffer" },
          ["k"] = { "<cmd>BufferLineCyclePrev<cr>", "previous buffer" },
        },
        ["M"] = { name = "surround/match",
          ["s"] = { name = "surround add" }
        },
        ["<leader>b"] = { name = "buffer",
          ["j"] = { "<cmd>BufferLineCycleNext<cr>", "next buffer" },
          ["k"] = { "<cmd>BufferLineCyclePrev<cr>", "previous buffer" },
          ["h"] = { "<cmd>BufferLineCloseLeft<cr>", "close left" },
          ["l"] = { "<cmd>BufferLineCloseRight<cr>", "close right" },
          ["s"] = { "<cmd>BufferLinePick<cr>", "pick" },
          ["c"] = { "<cmd>BufferLinePickClose<cr>", "pick close" },
          ["q"] = { function() require("mini.bufremove").delete(0, false) end, "Delete Buffer" },
        },
        ["<leader>c"] = { name = "code" },
        ["<leader>f"] = { name = "file/find" },
        ["<leader>g"] = { name = "git",
          ["g"] = { "<cmd>lua _Gitui_toggle()<cr>", "Gitui" }
        },
        ["<leader>q"] = { name = "quit/session" },
        ["<leader>s"] = { name = "search" },
        ["<leader>u"] = { name = "  Ui-Toggles",
          ["t"] = { "<cmd>ToggleTerm<cr>", "Terminal" }
        },
        ["<leader>x"] = { name = "diagnostics/quickfix" },
        ["<leader>e"] = { "<cmd>lua _Lf_toggle()<cr>", "Lf (current dir)" },
        ["<leader>."] = { "<cmd>lua _Lf_reset_to_root()<cr>", "Lf reset to root" },
        ["<leader>E"] = { "<cmd>lua _Lf_root_toggle()<cr>", "Lf (root dir)" }
      }

      wk.register(keymaps)
    end,
  },
}
