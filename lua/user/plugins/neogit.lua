return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  dependencies = 'nvim-lua/plenary.nvim',
  opts = {
    commit_editor = {
      show_staged_diff = false, -- INFO: Disabled because this freezes neogit for very large commits
    }
  },
  keys = {
    {
      '<leader>gg',
      "<cmd>Neogit<cr>",
      desc = 'Neogit',
    },
  },
}
