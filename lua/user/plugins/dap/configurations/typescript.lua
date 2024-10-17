local dap = require 'dap'

dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.stdpath 'data' .. '/mason' .. '/packages/node-debug2-adapter/out/src/nodeDebug.js' },
}

dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.stdpath 'data' .. '/mason' .. '/packages/firefox-debug-adapter/dist/adapter.bundle.js' },
}

local configurations = {
  {
    name = 'Debug with Node2 (launch)',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Debug with Node2 (Attach -> requires $(node --inspect-brk) flag)',
    type = 'node2',
    request = 'attach',
    cwd = '${workspaceFolder}',
    processId = require('dap.utils').pick_process,
  },
  {
    name = 'Debug with Firefox (launch)',
    type = 'firefox',
    request = 'launch',
    reAttach = true,
    url = function()
      local value = vim.fn.input 'URL: [localhost:3000] '
      if value ~= '' then
        return value
      end
      return 'localhost:3000'
    end,
    webRoot = '${workspaceFolder}',
    firefoxExecutable = '/Applications/Firefox.app/Contents/MacOS/firefox-bin',
  },
  {
    name = 'Debug with Firefox (Attach -> requires /Applications/Firefox.app/Contents/MacOS/firefox -start-debugger-server)',
    type = 'firefox',
    request = 'attach',
    reAttach = true,
    url = function()
      local value = vim.fn.input 'URL: [localhost:3000] '
      if value ~= '' then
        return value
      end
      return 'localhost:3000'
    end,
    webRoot = '${workspaceFolder}',
    firefoxExecutable = '/Applications/Firefox.app/Contents/MacOS/firefox-bin',
  },
}

dap.configurations.typescript = configurations
dap.configurations.typescriptreact = configurations
dap.configurations.javascriptreact = configurations
dap.configurations.javascript = configurations
