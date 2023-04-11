return {
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    config = function()
      local mason_null_ls = require 'mason-null-ls'
      local null_ls = require 'null-ls'

      mason_null_ls.setup {
        ensure_installed = {
          -- Opt to list sources here, when available in mason.
          'eslint_d',
          'prettierd',
          'styllua',
          'shfm',
        },
        automatic_installation = false,
        automatic_setup = true, -- Recommended, but optional
        handlers = {},
      }

      -- Extend null_ls builtins before they are beeing setup:
      vim.list_extend(null_ls.builtins.formatting.prettier.filetypes, { 'twig', 'svelte' })
      vim.list_extend(null_ls.builtins.diagnostics.eslint.filetypes, { 'svelte' })

      null_ls.setup {
        sources = {
          -- Add Anything not supported by mason or extended.
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.diagnostics.eslint,
        },
      }
    end,
  },
}
