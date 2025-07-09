return {
  pack = {
    src = 'https://github.com/akinsho/git-conflict.nvim',
    version = '*'
  },
  lazy = {
    'git-conflict.nvim',
    after = function()
      vim.api.nvim_set_hl(0, 'GitConflictCurrent', {
        bg = '#2A3B2E', -- Darker green background
        fg = '#A6E3A1', -- Catppuccin green text
      })

      vim.api.nvim_set_hl(0, 'GitConflictIncoming', {
        bg = '#1E2A3B', -- Darker blue background
        fg = '#89B4FA', -- Catppuccin blue text
      })

      vim.api.nvim_set_hl(0, 'GitConflictAncestor', {
        bg = '#2E263B', -- Darker mauve background
        fg = '#CBA6F7', -- Catppuccin mauve text
      })

      require('git-conflict').setup({
        highlights = {
          incoming = 'GitConflictIncoming',
          current = 'GitConflictCurrent',
          ancestor = 'GitConflictAncestor',
        }
      })
    end
  }
}
