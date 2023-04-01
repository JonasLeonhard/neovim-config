return {
  {
    "catppuccin/nvim", name = "catppuccin",
    opts = {
      flavour = 'mocha',
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        navic = true,
        dap = true,
        bufferline = true,
        hop = true,
        mason = true,
        noice = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        harpoon = true
      }
    },
    config = function(_, opts)
      require('catppuccin').setup(opts)
      vim.cmd.colorscheme "catppuccin"
    end
  }
}
