return {
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    lazy = true,
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        always_show_bufferline = false,
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
    end,
  },
}
