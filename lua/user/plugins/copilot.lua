return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    lazy = true,
    keys = {
      { '<leader>ac', '<cmd>CopilotPanel<cr>', desc = 'CopilotPanel' },
      {
        '<leader>a<Enter>',
        function()
          require('copilot.panel').accept()
        end,
        desc = 'Accept CopilotPanel suggestion'
      },
      {
        '<leader>an',
        function()
          require('copilot.panel').jump_next()
        end,
        desc = 'Accept CopilotPanel suggestion'
      },
      {
        '<leader>ap',
        function()
          require('copilot.panel').jump_prev()
        end,
        desc = 'Accept CopilotPanel suggestion'
      },
      {
        '<leader>aR',
        function()
          require('copilot.panel').refresh()
        end,
        desc = 'Accept CopilotPanel suggestion'
      },
    },
    config = function()
      require('copilot').setup {
        suggestion = { enabled = false }, -- suggestion disabled because it's conflicting with cmp ghost text
        panel = {
          layout = {
            ratio = 0.6,
          },
        },
      }
    end,
  },
}
