return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    event = 'VeryLazy',
    lazy = true,
    keys = {
      {
        '<leader>ut',
        '<cmd>ToggleTerm<cr>',
        desc = 'Terminal',
      },
      {
        '<leader>D',
        function()
          _LazyDocker_toggle()
        end,
        desc = 'LazyDocker',
      },
    },
    opts = {
      direction = 'horizontal',       -- default direction
      size = vim.fn.winheight(0) / 3, -- split size
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'none', -- | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        -- like `size`, width and height can be a number or function which is passed the current terminal
        width = 10000,
        height = 10000,
        winblend = 3,
        zindex = 10000,
      },
    },
    config = function(_, opts)
      local toggleTerm = require 'toggleterm'
      toggleTerm.setup(opts)
      local Terminal = require('toggleterm.terminal').Terminal

      -- ---------------------- LazyDocker -----------------------------------
      local lazydocker = Terminal:new { cmd = 'cd; lazydocker', hidden = true, direction = 'float' }
      function _LazyDocker_toggle()
        lazydocker:toggle()
      end

      -- ------------------- Keymaps ----------------------------------
      function _Set_terminal_keymaps()
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { buffer = 0 })
      end

      vim.cmd 'autocmd! TermOpen term://* lua _Set_terminal_keymaps()'
    end,
  },
}
