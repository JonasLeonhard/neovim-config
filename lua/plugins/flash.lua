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
      mode = { 'n', 'o' },
      "<cmd>lua require('flash').jump({ search = { mode = 'exact' }})<cr>",
      desc = 'Flash',
    },
    {
      'r',
      mode = 'o',
      "<cmd>lua require('flash').remote({ search = { mode = 'fuzzy' }})<cr>",
      desc = 'Remote Flash',
    }
  },
}
