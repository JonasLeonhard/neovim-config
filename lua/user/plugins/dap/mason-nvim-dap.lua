return {
  'jay-babu/mason-nvim-dap.nvim',
  dependencies = { 'williamboman/mason.nvim', 'mfussenegger/nvim-dap' },
  config = function()
    require('mason-nvim-dap').setup {
      automatic_installation = true,
      automatic_setup = true,
    }

    require('mason-nvim-dap').setup_handlers {}
  end,
}
