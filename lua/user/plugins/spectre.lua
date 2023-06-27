return {
  'windwp/nvim-spectre',
  lazy = true,
  keys = {
    {
      '<leader>sr',
      function()
        require('spectre').open_file_search({ select_word = true })
      end,
      desc = 'replace in current file (Spectre)',
    },
    {
      '<leader>sR',
      function()
        require('spectre').open_visual({ select_word = true })
      end,
      desc = 'Replace in files globally (Spectre)',
    },
  },
  config = function()
    require('spectre').setup()
  end,
}
