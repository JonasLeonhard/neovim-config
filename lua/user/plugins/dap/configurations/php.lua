local dap = require 'dap'

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { vim.fn.stdpath 'data' .. '/mason' .. '/packages/php-debug-adapter/extension/out/phpDebug.js' },
}

dap.configurations.php = {
  {
    name = 'Listen for Xdebug',
    type = 'php',
    request = 'launch',
    port = function()
      local value = tonumber(vim.fn.input 'Port: [9003] ')
      if value ~= '' then
        return value
      end
      return 9003
    end,
  },
  {
    name = 'Debug with Xdebug (remote with server->local pathMappings [/app <--> ${workspaceFolder}/site)]',
    type = 'php',
    request = 'launch',
    port = function()
      local value = tonumber(vim.fn.input 'Port: [9003] ')
      if value ~= '' then
        return value
      end
      return 9003
    end,
    -- server -> local mappings
    pathMappings = {
      ['/app'] = '${workspaceFolder}/site',
    },
  },
  {
    name = 'Debug with Xdebug (remote with server->local pathMappings [/<input> <--> ${workspaceFolder}/<input>)]',
    type = 'php',
    request = 'launch',
    port = function()
      local value = tonumber(vim.fn.input 'Port: [9003] ')
      if value ~= '' then
        return value
      end
      return 9003
    end,
    -- server -> local mappings
    pathMappings = function()
      local path = vim.fn.input 'Path: '
      return { ['/' .. path] = '${workspaceFolder}/' .. path }
    end,
  },
  {
    name = 'Debug currently open script',
    type = 'php',
    request = 'launch',
    port = function()
      local value = tonumber(vim.fn.input 'Port: [9003] ')
      if value ~= '' then
        return value
      end
      return 9003
    end,
    cwd = '${fileDirname}',
    program = '${file}',
    runtimeExecutable = 'php',
  },
}
