return {
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = 'VeryLazy',
    lazy = true,
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      indent = {
        char = '┊',
      },
      scope = {
        show_start = false, -- no underline of scope start
      },
    },
    main = 'ibl',
    config = function(_, opts)
      local hooks = require 'ibl.hooks'
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'IblScope', { fg = '#585B70' })
      end)
      require('ibl').setup(opts)
    end,
  },
}
