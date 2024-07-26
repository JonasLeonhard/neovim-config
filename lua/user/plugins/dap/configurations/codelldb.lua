local dap = require 'dap'

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

      local execs = vim.fn.glob(
        root .. '/zig-out/bin/*',
        false,
        true
      )
      local test_execs = vim.fn.glob(
        root .. '/zig-cache/o/*/test',
        false,
        true
      )

      local all_paths = {}

      vim.list_extend(all_paths, execs)
      vim.list_extend(all_paths, test_execs)

      local for_display = { "Select executable:" }

      for index, value in ipairs(all_paths) do
        table.insert(for_display, string.format("%d. %s", index, value))
      end

      local choice = vim.fn.inputlist(for_display)
      local final_choice = all_paths[choice]

      return final_choice
    end
    ,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}
