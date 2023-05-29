return {
  "jackMort/ChatGPT.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  },
  config = function()
    require("chatgpt").setup({
      edit_with_instructions = {
        diff = true,
      },
      chat = {
        question_sign = " ",
        keymaps = {
          close = "<C-c>",
          submit = "<C-s>",
          yank_last = "<C-y>",
          yank_last_code = "<C-k>",
          scroll_up = "<C-u>",
          scroll_down = "<C-d>",
          toggle_settings = "<C-o>",
          new_session = "<C-n>",
          cycle_windows = "<Tab>",
        }
      },
      popup_layout = {
        default = "center",
        center = {
          width = "100%",
          height = "100%",
        },
        right = {
          width = "30%",
          width_settings_open = "50%",
        },
      },
      popup_window = {
        filetype = "chatgpt",
        border = {
          highlight = "GPTBorder",
          style = "single",
          text = {
            top_align = "left",
            top = " Model "
          },
        },
        win_options = {
          winhighlight = "Normal:TelescopeNormal",
        },
      },
      popup_input = {
        prompt = " : ",
        border = {
          highlight = "GPTBorder",
          style = "single",
          text = {
            top_align = "left",
            top =
                " Prompt: ["
                .. "Submit: <C-s>,"
                .. " yank_last/accept: <C-y>,"
                .. " yank_last_code: <C-k>,"
                .. " cycle_windows: <Tab> "
                .. " opts: <C-o> "
                .. "]",
          },
        },
        win_options = {
          winhighlight = "Normal:TelescopeNormal",
        },
        submit = "<C-s>",
      },
    })

    vim.api.nvim_set_hl(0, "GPTBorder", { fg = '#181825' })
  end,
}
