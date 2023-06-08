return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    event = 'VeryLazy',
    lazy = true,
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
