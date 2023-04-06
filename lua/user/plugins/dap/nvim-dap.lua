return {
  'mfussenegger/nvim-dap',
  dependencies = { 'williamboman/mason.nvim', 'theHamsta/nvim-dap-virtual-text' },
  config = function()
    require('nvim-dap-virtual-text').setup()
    require 'user.plugins.dap.configurations.go'
    require 'user.plugins.dap.configurations.lua'
    require 'user.plugins.dap.configurations.php'
    require 'user.plugins.dap.configurations.rust'
    require 'user.plugins.dap.configurations.typescript'
  end,
}
