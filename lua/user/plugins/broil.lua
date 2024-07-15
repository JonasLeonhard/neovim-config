return {
  'JonasLeonhard/broil',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
      build = 'make',
    },
  },
  opts = {
    -- you could use different commands here, the default works for nushell and bash
    -- mv_command = 'mv <FROM> <TO>',
    -- rm_command = 'rm -r --trash <FROM>', -- think about using a trash rm command?
    -- mkdir_command = 'mkdir <TO>',
    -- touch_command = 'mkdir (dirname <TO>); touch <TO>',
  },
  dev = true, -- This will use {config.dev.path}/broil/ instead of fetching it from Github
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
    { '<leader>e', '<cmd>BroilToggleNetrw %:p:h<cr>', desc = 'Netrw' },
    { '<leader>E', '<cmd>BroilToggleNetrw<cr>', desc = 'Netrw (cwd)' },
  },
}
