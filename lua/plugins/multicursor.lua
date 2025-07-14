return {
  pack = {
    src = 'https://github.com/jake-stewart/multicursor.nvim',
  },
  lazy = {
    "multicursor.nvim",
    keys = {
      {
        '<leader>vn',
        function()
          require('multicursor-nvim').matchAddCursor(1)
        end,
        desc = 'Add a cursor and jump to the next word under cursor',
      },
      {
        '<leader>vN',
        function()
          require('multicursor-nvim').matchAddCursor(-1)
        end,
        desc = 'Add a cursor and jump to the prev word under cursor',
      },
      {
        '<leader>vs',
        function()
          require('multicursor-nvim').matchSkipCursor(1)
        end,
        desc = 'Skip a cursor and jump to the next word under cursor',
      },
      {
        '<leader>vS',
        function()
          require('multicursor-nvim').matchSkipCursor(-1)
        end,
        desc = 'Skip a cursor and jump to the prev word under cursor',
      },
      {
        '<leader>vk',
        function()
          require('multicursor-nvim').addCursor 'k'
        end,
        desc = 'Add cursors above the main cursor',
      },
      {
        '<leader>vj',
        function()
          require('multicursor-nvim').addCursor 'j'
        end,
        desc = 'Add cursors below the main cursor',
      },
      {
        '<leader>vl',
        function()
          require('multicursor-nvim').nextCursor()
        end,
        desc = 'Rotate the main cursor to the next',
      },
      {
        '<leader>vh',
        function()
          require('multicursor-nvim').prevCursor()
        end,
        desc = 'Rotate the main cursor to the previous',
      },
      {
        '<leader>vq',
        function()
          local mc = require 'multicursor-nvim'
          if mc.cursorsEnabled() then
            mc.disableCursors()
          else
            mc.enableCursors()
          end
        end,
        desc = 'Toggle multicursor mode',
      },
      {
        '<leader>va',
        function()
          require('multicursor-nvim').alignCursors()
        end,
        desc = 'Align cursor columns',
      },
      {
        '<leader>vt',
        function()
          require('multicursor-nvim').transposeCursors(1)
        end,
        desc = 'Rotate visual selection contents',
      },
      {
        '<leader>vT',
        function()
          require('multicursor-nvim').transposeCursors(-1)
        end,
        desc = 'Rotate visual selection contents (-1)',
      },
      {
        'S',
        function()
          require('multicursor-nvim').splitCursors()
        end,
        desc = 'Split cursors',
        mode = { 'v' },
      },
      {
        'M',
        function()
          require('multicursor-nvim').matchCursors()
        end,
        desc = 'Match cursors',
        mode = { 'v' },
      },
      {
        'I',
        function()
          require('multicursor-nvim').insertVisual()
        end,
        mode = { 'v' },
      },
      {
        'A',
        function()
          require('multicursor-nvim').appendVisual()
        end,
        mode = { 'v' },
      },
      {
        'v',
        function()
          require('multicursor-nvim').visualToCursors()
        end,
        mode = { 'v' },
      },
    },
    after = function()
      require("multicursor-nvim").setup({});

      vim.api.nvim_set_hl(0, 'MultiCursorCursor', { link = 'Cursor' })
      vim.api.nvim_set_hl(0, 'MultiCursorVisual', { link = 'Visual' })
      vim.api.nvim_set_hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
      vim.api.nvim_set_hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })

      -- override the default esc handler to clear multicursors(see whichkey.lua)
      vim.keymap.set('n', '<esc>', function()
        print 'esc called...'
        local mc = require 'multicursor-nvim'
        if mc.hasCursors() then
          mc.clearCursors()
        end
        vim.cmd 'noh'
      end, { remap = true })
    end,
  }
}
