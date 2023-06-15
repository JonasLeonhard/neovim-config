return {
  {
    'jay-babu/mason-null-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jose-elias-alvarez/null-ls.nvim',
    },
    event = 'VeryLazy',
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
          'eslint_d',
          'prettierd',
          'styllua',
          'shfm',
        },
        automatic_installation = false,
        automatic_setup = true, -- Recommended, but optional
        handlers = {
          eslint_d = function() end, -- disable automatic setup: see (1)
        },
      }

      -- So we check if a .pnp.cjs file is in the project and switch to plain eslint

      -- handling yarn berry and pnpm:
      local command_resolver = require 'null-ls.helpers.command_resolver'

      null_ls.setup {
        -- Add Anything not supported by mason or extended edgecases.
        sources = {
          -- (1) We can use `eslint_d` if we don't use Yarn PnP.
          null_ls.builtins.diagnostics.eslint_d.with {
            condition = function(utils)
              return not utils.root_has_file '.pnp.cjs'
            end,
          },
          null_ls.builtins.code_actions.eslint_d.with {
            condition = function(utils)
              return not utils.root_has_file '.pnp.cjs'
            end,
          },

          -- (1) We have to fall back to `eslint` if we use Yarn PnP. `eslint_d` is not able to resolve
          -- plugins inside the `eslintrc.cjs` configuration file.
          null_ls.builtins.diagnostics.eslint.with {
            dynamic_command = command_resolver.from_yarn_pnp(),
            condition = function(utils)
              return utils.root_has_file '.pnp.cjs'
            end,
          },
          null_ls.builtins.code_actions.eslint.with {
            dynamic_command = command_resolver.from_yarn_pnp(),
            condition = function(utils)
              return utils.root_has_file '.pnp.cjs'
            end,
          },
        },
      }
    end,
  },
}
