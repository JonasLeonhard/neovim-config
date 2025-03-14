local dap = require 'dap'

-- go debuggin requires delve + go-debug-adapter
dap.adapters.go = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.stdpath 'data' .. '/mason' .. '/packages/go-debug-adapter/extension/dist/debugAdapter.js' },
}

dap.configurations.go = {
  {
    type = 'go',
    name = 'Debug',
    request = 'launch',
    showLog = false,
    program = '${file}',
    dlvToolPath = vim.fn.exepath 'dlv', -- Adjust to where delve is installed
  },
}
