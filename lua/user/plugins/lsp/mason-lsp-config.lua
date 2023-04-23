return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { "mason.nvim", "neovim/nvim-lspconfig", "folke/neodev.nvim", "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      --  This function gets run when an LSP connects to a particular buffer.
      local on_attach = require("user.plugins.lsp.helpers.on_attach")
      local server_settings = require("user.plugins.lsp.helpers.server_settings")

      mason_lspconfig.setup()
      mason_lspconfig.setup {
        ensure_installed = vim.tbl_keys(server_settings),
      }

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)


      mason_lspconfig.setup_handlers {
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = server_settings[server_name],
          }
        end,
      }
    end
  },
}
