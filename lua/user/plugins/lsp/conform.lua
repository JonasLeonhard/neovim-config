return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { "BufWritePre" },
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
  opts = {
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
    },
    format_on_save = function()
      if not _AutoFormatEnabled() then
        return
      end

      return { async = false, timeout_ms = 500, lsp_fallback = true }
    end,
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
  config = function(_, opts)
    local conform = require 'conform'
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

    conform.setup(opts)
  end,
}
