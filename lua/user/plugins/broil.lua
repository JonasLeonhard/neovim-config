return {
  'JonasLeonhard/broil',
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    mappings = {
      synchronize = '<C-y>',
      help = '?',
    }
  },
  dev = true, -- This will use {config.dev.path}/broil/ instead of fetching it from Github
  keys = {
    {
      '<leader>o',
      "<cmd>lua require('broil').open()<cr>",
      desc = 'Broil open',
    },
  },
  enabled = false
}
