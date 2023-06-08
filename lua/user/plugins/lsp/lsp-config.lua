-- LSP Configuration & Plugins
return {
  'neovim/nvim-lspconfig',
  dependencies = { 'mason.nvim', 'folke/neodev.nvim' },
  event = 'VeryLazy',
  lazy = true,
}
