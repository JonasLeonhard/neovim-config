return {
  'JonasLeonhard/broil',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
      build =
      'make'
    }
  },
  opts = {
    rm_command = 'rm --trash', -- you could use a trash command here. Or rm --trash for nushell...
  },
  dev = true,                  -- This will use {config.dev.path}/broil/ instead of fetching it from Github
  keys = {
    {
      '<leader>o',
      "<cmd>lua require('broil').open()<cr>", -- opens current %:h or cwd by default
      desc = 'Broil open',
    },
    {
      '<leader>O',
      "<cmd>lua require('broil').open(vim.fn.getcwd())<cr>",
      desc = 'Broil open',
    },
  },
}
