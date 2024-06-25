return {
  'stevearc/conform.nvim',
  lazy = true,
  event = 'User FileOpened',
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
  },
  opts = {
    log_level = vim.log.levels.DEBUG,
    formatters_by_ft = {
      css = { { 'prettierd', 'prettier' } },
      graphql = { { 'prettierd', 'prettier' } },
      html = { { 'prettierd', 'prettier' } },
      javascript = { { 'prettierd', 'prettier' } },
      javascriptreact = { { 'prettierd', 'prettier' } },
      json = { { 'prettierd', 'prettier' } },
      lua = { 'stylua' },
      python = { 'isort', 'black' },
      scss = { { 'prettierd', 'prettier' } },
      svelte = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
      vue = { { 'prettierd', 'prettier' } },
      yaml = { { 'prettierd', 'prettier' } },
      twig = { 'djlint' },
      astro = { { 'prettierd', 'prettier' } },
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
}
