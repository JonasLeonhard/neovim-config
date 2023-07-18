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

      null_ls.setup {
        debug = true,
      }
      mason_null_ls.setup {
        ensure_installed = {
          -- Opt to list sources here, when available in mason.
          'djlint',
          'phpstan',
          'prettierd',
          'shfm',
          'styllua',
          'twigcs',
        },
        automatic_installation = false,
        automatic_setup = true, -- Recommended, but optional
        handlers = {
          eslint_d = function()
            -- disable automatic setup for eslint_d,
            -- this is because eslind_d wont work correctly with yarn berry pnp,
            -- it is therefore recommended to use the eslint-lsp instead.
            print 'You have installed eslint_d via mason_null_ls linters. This can cause problems with yarn berry. Use the eslint lsp instead'
          end,
          phpstan = function()
            null_ls.register(null_ls.builtins.diagnostics.phpstan.with {
              timeout = 100000,
              extra_args = { '--memory-limit=-1', '-c', 'phpstan.neon' },
              condition = function(utils)
                return utils.root_has_file 'phpstan.neon'
              end,
            })
          end,
          prettierd = function()
            vim.list_extend(null_ls.builtins.formatting.prettierd.filetypes, { 'svelte', 'vue' })
            null_ls.register(null_ls.builtins.formatting.prettierd)
          end,
          djlint = function()
            null_ls.register(null_ls.builtins.formatting.djlint.with {
              extra_args = {
                '--profile=nunjucks',
                '--preserve-blank-lines',
                '--indent=2',
                '--line-break-after-multiline-tag',
              },
              filetypes = { 'twig' },
            })
          end,
        },
      }
    end,
  },
}
