return {
   'nvimdev/indentmini.nvim',
   event = 'User FileOpened',
   lazy = true,
   opts = {
      char = '┊'
   },
   config = function(_, opts)
      vim.cmd.highlight("default link IndentLine Comment")
      vim.api.nvim_set_hl(0, 'IndentLine', { fg = '#313244' })
      require('indentmini').setup(opts)
   end
}
