return {
  'linrongbin16/lsp-progress.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lsp-progress').setup()

    -- listen lsp-progress event and refresh lualine
    vim.api.nvim_create_augroup('lualine_augroup', { clear = true })
    vim.api.nvim_create_autocmd('User LspProgressStatusUpdated', {
      group = 'lualine_augroup',
      callback = require('lualine').refresh,
    })
  end,
}
