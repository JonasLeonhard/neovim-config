return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'mason.nvim', 'neovim/nvim-lspconfig' },
    event = 'User FileOpened',
    lazy = true,
    config = function()
      local mason_lspconfig = require 'mason-lspconfig'
      local lspconfig = require 'lspconfig'
      local lspconfig_settings = require 'user.plugins.lsp.helpers.server_settings'

      mason_lspconfig.setup { ensure_installed = vim.tbl_keys(lspconfig_settings) }

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

      -- add other capabilities -- for nvim-ufo:
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      mason_lspconfig.setup_handlers {
        function(server_name) -- gets called from mason_lspconfig for each installed lsp
          lspconfig[server_name].setup(vim.tbl_deep_extend('force', lspconfig_settings[server_name] or {}, {
            capabilities = capabilities,
          }))
        end,
      }
    end,
  },
}
