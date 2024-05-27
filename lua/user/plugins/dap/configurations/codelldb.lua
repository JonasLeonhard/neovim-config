local dap = require 'dap'

dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.fn.exepath('codelldb'),
    args = { '--port', '${port}' },
  },
}

dap.configurations.rust = {
  {
    name = 'LLDB: Launch',
    type = 'codelldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    console = 'integratedTerminal',
  },
}
