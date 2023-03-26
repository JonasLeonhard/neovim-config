return {
  {
    "akinsho/bufferline.nvim",
    requires = 'nvim-tree/nvim-web-devicons',
    event = "VeryLazy",
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
      }
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
    end
  }
}
