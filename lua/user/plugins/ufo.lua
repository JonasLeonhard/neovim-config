return {
  'kevinhwang91/nvim-ufo',
  dependencies = { 'kevinhwang91/promise-async', 'williamboman/mason-lspconfig.nvim' },
  opts = true,
  lazy = true,
  event = 'User FileOpened',
}
