return {
  pack = {
    src = 'https://github.com/stevearc/conform.nvim',
  },

  lazy = {
    'conform.nvim',
    event = "BufWritePre",
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { timeout_ms = 500, lsp_format = 'fallback' }
        end,
        desc = 'Format',
        mode = { 'n', 'v' },
      },
      {
        '<leader>cF',
        function()
          require('conform').format { timeout_ms = tonumber(vim.fn.input 'timout_ms: '), lsp_format = 'fallback' }
        end,
        desc = 'Format (ask for timout_ms)',
        mode = { 'n', 'v' },
      },
    },
    before = function()
      -- init function content goes in before hook
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
    after = function()
      local conform = require 'conform'

      -- Custom formatter configuration
      conform.formatters.djlint = {
        args = {
          '--reformat',
          '--preserve-blank-lines',
          '--line-break-after-multiline-tag',
          '--indent',
          '2',
          '-',
        },
      }

      -- Main setup
      conform.setup({
        log_level = vim.log.levels.DEBUG,
        formatters_by_ft = {
          css = { 'prettierd', 'prettier', stop_after_first = true },
          graphql = { 'prettierd', 'prettier', stop_after_first = true },
          html = { 'prettierd', 'prettier', stop_after_first = true },
          javascript = { 'prettierd', 'prettier', stop_after_first = true },
          javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
          json = { 'prettierd', 'prettier', stop_after_first = true },
          lua = { 'stylua', stop_after_first = true },
          python = { 'isort', 'black', stop_after_first = true },
          scss = { 'prettierd', 'prettier', stop_after_first = true },
          svelte = { 'prettierd', 'prettier', stop_after_first = true },
          typescript = { 'prettierd', 'prettier', stop_after_first = true },
          typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
          vue = { 'prettierd', 'prettier', stop_after_first = true },
          yaml = { 'prettierd', 'prettier', stop_after_first = true },
          twig = { 'djlint' },
          astro = { 'prettierd', 'prettier', stop_after_first = true },
          odin = { 'odinfmt' }
        },
        format_after_save = function()
          if not _AutoFormatEnabled() then
            return
          end
          return { timeout_ms = 500, lsp_format = "fallback", }
        end,
      })
    end,
  }
}
