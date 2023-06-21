return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim', 'neovim/nvim-lspconfig', 'folke/neodev.nvim', 'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp' },
    event = 'User FileOpened',
    lazy = true,
    config = function()
      local mason_lspconfig = require 'mason-lspconfig'
      local lspconfig = require 'lspconfig'
      local lspconfig_settings = require 'user.plugins.lsp.helpers.server_settings'
      local on_attach = require 'user.plugins.lsp.helpers.on_attach'

      mason_lspconfig.setup({ ensure_installed = vim.tbl_keys(lspconfig_settings) })

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


      mason_lspconfig.setup_handlers {
        function(server_name) -- gets called from mason_lspconfig for each installed lsp
          lspconfig[server_name].setup(
            vim.tbl_deep_extend('force', lspconfig_settings[server_name] or {}, {
              on_attach = on_attach,
              capabilities = capabilities,
            })
          )
        end,
      }
    end,
  },
}
