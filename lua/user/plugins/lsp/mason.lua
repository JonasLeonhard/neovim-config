return {
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    lazy = true,
    config = function()
      require('mason').setup()
    end,
  },
}
