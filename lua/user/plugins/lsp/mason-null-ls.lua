return {
  {
    'jay-babu/mason-null-ls.nvim',
    event = 'User FileOpened',
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    lazy = true,
    config = function()
      local mason_null_ls = require 'mason-null-ls'
      local null_ls = require 'null-ls'

      -- Extend null_ls builtins before they are beeing setup:
      vim.list_extend(null_ls.builtins.formatting.prettier.filetypes, { 'twig', 'svelte' })
      vim.list_extend(null_ls.builtins.diagnostics.eslint.filetypes, { 'svelte' })

      mason_null_ls.setup {
        ensure_installed = {
          -- Opt to list sources here, when available in mason.
          'prettierd',
          'styllua',
          'shfm',
        },
        automatic_installation = false,
        automatic_setup = true, -- Recommended, but optional
        handlers = {
          eslint_d = function()
            -- disable automatic setup for eslint_d,
            -- this is because eslind_d wont work correctly with yarn berry pnp,
            -- it is therefore recommended to use the eslint-lsp instead.
            print(
              "You have installed eslint_d via mason_null_ls linters. This can cause problems with yarn berry. Use the eslint lsp instead")
          end,
          phpstan = function()
            null_ls.register(null_ls.builtins.diagnostics.phpstan.with({
              cwd = function(pattern)
                return require('lspconfig.util').root_pattern('composer.json', '.git')(pattern.bufname)
              end
            }))
          end
        },
      }
    end,
  },
}
