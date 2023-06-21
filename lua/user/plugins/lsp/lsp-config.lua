-- LSP Configuration & Plugins
return {
  'neovim/nvim-lspconfig',
  dependencies = { 'mason.nvim', 'folke/neodev.nvim' },
  event = 'User FileOpened',
  lazy = true,
}
