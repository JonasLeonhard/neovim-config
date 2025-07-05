return {
  pack = {
    { src = 'https://github.com/mfussenegger/nvim-dap' },
    { src = 'https://github.com/rcarriga/nvim-dap-ui' },
    { src = 'https://github.com/nvim-neotest/nvim-nio' },
  },

  lazy = {
    'nvim-dap',
    keys = {
      -- DAP UI key
      {
        '<leader>du',
        function()
          require('dapui').toggle()
        end,
        desc = 'Toggle UI',
      },
      {
        '<leader>dB',
        function()
          require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Breakpoint Condition',
      },
      {
        '<leader>dt',
        function()
          require('dap').toggle_breakpoint()
        end,
        desc = 'Toggle Breakpoint',
      },
      {
        '<leader>dc',
        function()
          require('dap').continue()
        end,
        desc = 'Continue',
      },
      {
        '<leader>da',
        function()
          require('dap').continue { before = get_args }
        end,
        desc = 'Run with Args',
      },
      {
        '<leader>dC',
        function()
          require('dap').run_to_cursor()
        end,
        desc = 'Run to Cursor',
      },
      {
        '<leader>dg',
        function()
          require('dap').goto_()
        end,
        desc = 'Go to Line (No Execute)',
      },
      {
        '<leader>di',
        function()
          require('dap').step_into()
        end,
        desc = 'Step Into',
      },
      {
        '<leader>dj',
        function()
          require('dap').down()
        end,
        desc = 'Down',
      },
      {
        '<leader>dk',
        function()
          require('dap').up()
        end,
        desc = 'Up',
      },
      {
        '<leader>dl',
        function()
          require('dap').run_last()
        end,
        desc = 'Run Last',
      },
      {
        '<leader>dO',
        function()
          require('dap').step_out()
        end,
        desc = 'Step Out',
      },
      {
        '<leader>do',
        function()
          require('dap').step_over()
        end,
        desc = 'Step Over',
      },
      {
        '<leader>dp',
        function()
          require('dap').pause()
        end,
        desc = 'Pause',
      },
      {
        '<leader>dr',
        function()
          require('dap').repl.toggle()
        end,
        desc = 'Toggle REPL',
      },
      {
        '<leader>ds',
        function()
          require('dap').session()
        end,
        desc = 'Session',
      },
      {
        '<leader>dT',
        function()
          require('dap').terminate()
        end,
        desc = 'Terminate',
      },
      {
        '<leader>dw',
        function()
          require('dap.ui.widgets').hover()
        end,
        desc = 'Widgets',
      },
    },
    after = function()
      -- Setup DAP UI first
      require('dapui').setup()

      -- Setup automatic DAP UI opening/closing
      local dap, dapui = require("dap"), require("dapui")
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.fn.sign_define('DapBreakpoint', { text = ' ', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
      vim.fn.sign_define('DapBreakpointCondition',
        { text = ' ', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
      vim.fn.sign_define('DapLogPoint', { text = ' ', texthl = 'DapLogPoint', linehl = '', numhl = '' })

      -- Setup adapters and configurations
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
          dlvToolPath = vim.fn.exepath 'dlv',
        },
      }

      local codelldb = {
        type = 'server',
        port = '${port}',
        executable = {
          command = vim.fn.exepath('codelldb'),
          args = { '--port', '${port}' },
        },
      }
      dap.adapters.codelldb = codelldb
      dap.adapters.lldb = codelldb

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

      dap.configurations.zig = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            local root = vim.fn.getcwd()
            local execs = vim.fn.glob(root .. '/zig-out/bin/*', false, true)
            local test_execs = vim.fn.glob(root .. '/zig-cache/o/*/test', false, true)
            local all_paths = {}
            vim.list_extend(all_paths, execs)
            vim.list_extend(all_paths, test_execs)
            local for_display = { "Select executable:" }
            for index, value in ipairs(all_paths) do
              table.insert(for_display, string.format("%d. %s", index, value))
            end
            local choice = vim.fn.inputlist(for_display)
            return all_paths[choice]
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }

      dap.adapters.nlua = function(callback, config)
        callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
      end

      dap.configurations.lua = {
        {
          type = 'nlua',
          request = 'attach',
          name = 'Neovim attach',
          host = function()
            local value = vim.fn.input 'Host [127.0.0.1]: '
            if value ~= '' then return value end
            return '127.0.0.1'
          end,
          port = function()
            local val = tonumber(vim.fn.input 'Port: ')
            assert(val, 'Please provide a port number')
            return val
          end,
        },
      }

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
            if value ~= '' then return value end
            return 9003
          end,
        },
        {
          name = 'Debug with Xdebug (remote with server->local pathMappings [/app <--> ${workspaceFolder}/site)]',
          type = 'php',
          request = 'launch',
          port = function()
            local value = tonumber(vim.fn.input 'Port: [9003] ')
            if value ~= '' then return value end
            return 9003
          end,
          pathMappings = {
            ['/app'] = '${workspaceFolder}/site',
          },
        },
        {
          name = 'Debug with Xdebug (remote with server->local pathMappings',
          type = 'php',
          request = 'launch',
          port = function()
            local value = tonumber(vim.fn.input 'Port: [9003] ')
            if value ~= '' then return value end
            return 9003
          end,
          pathMappings = function()
            local path = vim.fn.input 'Path (server): <yourinput>: '
            local pathLocal = vim.fn.input 'Path (local): ${workspaceFolder}<yourinput>: '
            return { [path] = '${workspaceFolder}' .. pathLocal }
          end,
        },
        {
          name = 'Debug currently open script',
          type = 'php',
          request = 'launch',
          port = function()
            local value = tonumber(vim.fn.input 'Port: [9003] ')
            if value ~= '' then return value end
            return 9003
          end,
          cwd = '${fileDirname}',
          program = '${file}',
          runtimeExecutable = 'php',
        },
      }

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

      local ts_configurations = {
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
            if value ~= '' then return value end
            return 'localhost:3000'
          end,
          webRoot = '${workspaceFolder}',
          firefoxExecutable = '/Applications/Firefox.app/Contents/MacOS/firefox-bin',
        },
        {
          name =
          'Debug with Firefox (Attach -> requires /Applications/Firefox.app/Contents/MacOS/firefox -start-debugger-server)',
          type = 'firefox',
          request = 'attach',
          reAttach = true,
          url = function()
            local value = vim.fn.input 'URL: [localhost:3000] '
            if value ~= '' then return value end
            return 'localhost:3000'
          end,
          webRoot = '${workspaceFolder}',
          firefoxExecutable = '/Applications/Firefox.app/Contents/MacOS/firefox-bin',
        },
      }

      dap.configurations.typescript = ts_configurations
      dap.configurations.typescriptreact = ts_configurations
      dap.configurations.javascriptreact = ts_configurations
      dap.configurations.javascript = ts_configurations
    end,
  }
}
