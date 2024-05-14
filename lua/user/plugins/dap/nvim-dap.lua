return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'williamboman/mason.nvim',
    'theHamsta/nvim-dap-virtual-text',
    {
      "rcarriga/nvim-dap-ui",
      dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
      lazy = true,
      keys = {
        {
          "<leader>du",
          function()
            require 'dapui'.toggle({ reset = true })
          end,
          desc = 'Toggle UI'
        }
      },
      config = function()
        require('dapui').setup()

        -- automatically open debugger
        local dap, dapui = require 'dap', require 'dapui'
        dap.listeners.after.event_initialized['dapui_config'] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated['dapui_config'] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited['dapui_config'] = function()
          dapui.close()
        end
      end,
    }
  },
  lazy = true,
  keys = {
    { '<leader>dt', "<cmd>lua require'dap'.toggle_breakpoint()<cr>",      desc = 'Toggle Breakpoint' },
    {
      '<leader>dT',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Toggle Breakpoint w. Condition',
    },
    { '<leader>db', "<cmd>lua require'dap'.step_back()<cr>",              desc = 'Step Back' },
    { '<leader>dc', "<cmd>lua require'dap'.continue()<cr>",               desc = 'Continue' },
    { '<leader>dC', "<cmd>lua require'dap'.run_to_cursor()<cr>",          desc = 'Run To Cursor' },
    { '<leader>dd', "<cmd>lua require'dap'.disconnect()<cr>",             desc = 'Disconnect' },
    { '<leader>dg', "<cmd>lua require'dap'.session()<cr>",                desc = 'Get Session' },
    { '<leader>di', "<cmd>lua require'dap'.step_into()<cr>",              desc = 'Step Into' },
    { '<leader>do', "<cmd>lua require'dap'.step_over()<cr>",              desc = 'Step Over' },
    { '<leader>du', "<cmd>lua require'dap'.step_out()<cr>",               desc = 'Step Out' },
    { '<leader>dp', "<cmd>lua require'dap'.pause()<cr>",                  desc = 'Pause' },
    { '<leader>dr', "<cmd>lua require'dap'.repl.toggle()<cr>",            desc = 'Toggle Repl' },
    { '<leader>ds', "<cmd>lua require'dap'.continue()<cr>",               desc = 'Start' },
    { '<leader>dq', "<cmd>lua require'dap'.close()<cr>",                  desc = 'Quit' },
    { '<leader>dU', "<cmd>lua require'dapui'.toggle({reset = true})<cr>", desc = 'Toggle UI' },
  },
  config = function()
    local sign = vim.fn.sign_define

    sign('DapBreakpoint', { text = ' ', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    sign('DapBreakpointCondition', { text = ' ', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
    sign('DapLogPoint', { text = ' ', texthl = 'DapLogPoint', linehl = '', numhl = '' })

    require('nvim-dap-virtual-text').setup {
      virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
    }
    require 'user.plugins.dap.configurations.go'
    require 'user.plugins.dap.configurations.lua'
    require 'user.plugins.dap.configurations.php'
    require 'user.plugins.dap.configurations.rust'
    require 'user.plugins.dap.configurations.typescript'
  end,
}
