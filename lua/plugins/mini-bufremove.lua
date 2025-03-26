return {
  {
    'echasnovski/mini.bufremove',
    lazy = true,
    keys = {
      {
        '<leader>bq',
        function()
          require('mini.bufremove').delete(0, false)
        end,
        desc = 'Delete Buffer',
      },
      {
        '<leader>bQ',
        function()
          require('mini.bufremove').delete(0, true)
        end,
        desc = 'Delete Buffer (force)',
      },
    }
  },
}
