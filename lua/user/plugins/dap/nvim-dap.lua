return {
  'mfussenegger/nvim-dap',
  dependencies = { 'williamboman/mason.nvim', 'theHamsta/nvim-dap-virtual-text' },
  config = function()
    local sign = vim.fn.sign_define

    sign('DapBreakpoint', { text = ' ', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    sign('DapBreakpointCondition', { text = ' ', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
    sign('DapLogPoint', { text = ' ', texthl = 'DapLogPoint', linehl = '', numhl = '' })

    require('nvim-dap-virtual-text').setup()
    require 'user.plugins.dap.configurations.go'
    require 'user.plugins.dap.configurations.lua'
    require 'user.plugins.dap.configurations.php'
    require 'user.plugins.dap.configurations.rust'
    require 'user.plugins.dap.configurations.typescript'
  end,
}
