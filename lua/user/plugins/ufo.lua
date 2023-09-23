return {
  'kevinhwang91/nvim-ufo',
  event = 'VeryLazy',
  lazy = true,
  dependencies = { 'kevinhwang91/promise-async', 'nvim-treesitter/nvim-treesitter' },
  opts = {
    provider_selector = function(bufnr, filetype, buftype)
      return { 'treesitter', 'indent' }
    end,
  }
}
