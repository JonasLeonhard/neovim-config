return {
  pack = {
    src = 'https://github.com/folke/flash.nvim',
  },

  lazy = {
    'flash.nvim',
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
    after = function()
      require('flash').setup({
        modes = {
          search = {
            enabled = false,
          },
          char = {
            label = { exclude = 'hjkliardcwbyog' },
          },
        },
      })
    end,
  }
}
