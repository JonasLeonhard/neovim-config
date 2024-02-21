return {
  'JonasLeonhard/broil',
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      cond = function()
        return vim.fn.executable 'cmake' == 1
      end,
      build =
      'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }
  },
  cond = function()
    return vim.fn.executable 'fd' == 1 -- https://github.com/sharkdp/fd
  end,
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
  enabled = true
}
