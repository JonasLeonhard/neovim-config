return {
  'folke/flash.nvim',
  lazy = true,
  ---@type Flash.Config
  opts = {
    modes = {
      search = {
        enabled = false,
      },
      char = {
        label = { exclude = 'hjkliardcwbyog' },
      },
    },
  },
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      "<cmd>lua require('flash').jump({ search = { mode = 'fuzzy' }})<cr>",
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'o', 'x' },
      "<cmd>lua require('flash').treesitter()<cr>",
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      "<cmd>lua require('flash').remote({ search = { mode = 'fuzzy' }})<cr>",
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      "<cmd>lua require('flash').treesitter_search()<cr>",
      desc = 'Flash Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      "<cmd>lua require('flash').toggle()<cr>",
      desc = 'Toggle Flash Search',
    },
  },
}
