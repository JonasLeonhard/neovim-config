return {
  'jackMort/ChatGPT.nvim',
  lazy = true,
  keys = {
    { '<leader>aa', '<cmd>ChatGPT<cr>',      desc = 'Chat' },
    { '<leader>aA', '<cmd>ChatGPTActAs<cr>', desc = 'ActAs Selection' },
    {
      '<leader>ae',
      "<cmd>lua require('chatgpt').edit_with_instructions()<cr>",
      desc = 'Edit Line(s) w. Instruction'
    },
    { '<leader>arg', '<cmd>ChatGPTRun grammar_correction<cr>', desc = 'grammar_correction' },
    { '<leader>art', '<cmd>ChatGPTRun translate<cr>',          desc = 'translate' },
    { '<leader>ark', '<cmd>ChatGPTRun keywords<cr>',           desc = 'keywords' },
    { '<leader>ard', '<cmd>ChatGPTRun docstring<cr>',          desc = 'docstring' },
    { '<leader>arT', '<cmd>ChatGPTRun add_tests<cr>',          desc = 'add_tests' },
    { '<leader>aro', '<cmd>ChatGPTRun optimize_code<cr>',      desc = 'optimize_code' },
    { '<leader>ars', '<cmd>ChatGPTRun summarize<cr>',          desc = 'summarize' },
    { '<leader>arf', '<cmd>ChatGPTRun fix_bugs<cr>',           desc = 'fix_bugs' },
    { '<leader>arE', '<cmd>ChatGPTRun explain_code<cr>',       desc = 'explain_code' },
    { '<leader>arr', '<cmd>ChatGPTRun roxygen_edit<cr>',       desc = 'roxygen_edit' },
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  opts = {
    edit_with_instructions = {
      diff = true,
    },
    chat = {
      question_sign = ' ',
      keymaps = {
        close = '<C-c>',
        submit = '<C-s>',
        yank_last = '<C-y>',
        yank_last_code = '<C-k>',
        scroll_up = '<C-u>',
        scroll_down = '<C-d>',
        toggle_settings = '<C-o>',
        new_session = '<C-n>',
        cycle_windows = '<Tab>',
      },
    },
    popup_layout = {
      default = 'center',
      center = {
        width = '100%',
        height = '100%',
      },
      right = {
        width = '30%',
        width_settings_open = '50%',
      },
    },
    popup_window = {
      filetype = 'chatgpt',
      border = {
        highlight = 'GPTBorder',
        style = 'single',
        text = {
          top_align = 'left',
          top = ' Model ',
        },
      },
      win_options = {
        winhighlight = 'Normal:TelescopeNormal',
      },
    },
    popup_input = {
      prompt = ' : ',
      border = {
        highlight = 'GPTBorder',
        style = 'single',
        text = {
          top_align = 'left',
          top = ' Prompt: ['
              .. 'Submit: <C-s>,'
              .. ' yank_last/accept: <C-y>,'
              .. ' yank_last_code: <C-k>,'
              .. ' cycle_windows: <Tab> '
              .. ' opts: <C-o> '
              .. ']',
        },
      },
      win_options = {
        winhighlight = 'Normal:TelescopeNormal',
      },
      submit = '<C-s>',
    },
    openai_params = {
      model = "gpt-4",
    },
  },
}
