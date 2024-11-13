return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = true,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    -- add any opts here
    windows = {
      ---@type "right" | "left" | "top" | "bottom"
      position = "bottom",
      width = 100,
      edit = {
        border = { { " ", "FloatBorder" },
          { " ", "FloatBorder" },
          { " ", "FloatBorder" },
          { " ", "FloatBorder" },
          { "",  "FloatBorder" },
          { "",  "FloatBorder" },
          { "",  "FloatBorder" },
          { "",  "FloatBorder" },
        },
      },
      ask = {
        border = { { " ", "FloatBorder" },
          { " ", "FloatBorder" },
          { " ", "FloatBorder" },
          { " ", "FloatBorder" },
          { "",  "FloatBorder" },
          { "",  "FloatBorder" },
          { "",  "FloatBorder" },
          { "",  "FloatBorder" },
        },
      },

    },
    hints = { enabled = false },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    {

      'stevearc/dressing.nvim', -- i dont want to use dressing as my defaults, but avante throws an error without it
      event = "VeryLazy",
      lazy = true,
      opts = {
        input = {
          enabled = false,
        },
        select = {
          enabled = false,
        }
      },
    },
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  },
}
