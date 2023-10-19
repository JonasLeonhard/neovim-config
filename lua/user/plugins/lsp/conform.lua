return {
  'stevearc/conform.nvim',
  lazy = true,
  event = 'BufWritePre',
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format()
      end,
      desc = 'Format',
      mode = 'n',
    },
    {
      '<leader>cf',
      function()
        require('conform').format()
      end,
      desc = 'Format Selection',
      mode = 'v',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettierd', 'prettier' },
      javascriptreact = { 'prettierd', 'prettier' },
      typescript = { 'prettierd', 'prettier' },
      typescriptreact = { 'prettierd', 'prettier' },
      vue = { 'prettierd', 'prettier' },
      svelte = { 'prettierd', 'prettier' },
    },
    format_on_save = function()
      if not _AutoFormatEnabled() then
        return
      end
      return { timeout_ms = 500, lsp_fallback = true }
    end,
  },
}
