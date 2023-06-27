return {
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "User FileOpened",
    lazy = true,
    keys = {
      { 'gk',         '<cmd>BufferLineCycleNext<cr>',  desc = 'next buffer',     mode = 'n' },
      { 'gj',         '<cmd>BufferLineCyclePrev<cr>',  desc = 'previous buffer', mode = 'n' },
      { '<leader>bj', '<cmd>BufferLineCycleNext<cr>',  desc = 'next buffer' },
      { '<leader>bk', '<cmd>BufferLineCyclePrev<cr>',  desc = 'previous buffer' },
      { '<leader>bh', '<cmd>BufferLineCloseLeft<cr>',  desc = 'close left' },
      { '<leader>bl', '<cmd>BufferLineCloseRight<cr>', desc = 'close right' },
      { '<leader>bs', '<cmd>BufferLinePick<cr>',       desc = 'pick' },
      { '<leader>bc', '<cmd>BufferLinePickClose<cr>',  desc = 'pick close' },
    },
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
