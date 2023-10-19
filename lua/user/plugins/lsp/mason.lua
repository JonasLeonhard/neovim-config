return {
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    lazy = true,
    opts = {
      ensure_installed = {
        "stylua",
        "prettierd"
      },
    }
  },
}
