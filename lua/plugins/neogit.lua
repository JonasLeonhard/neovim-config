return {
  pack = {
    src = 'https://github.com/NeogitOrg/neogit',
    -- dependencies = 'nvim-lua/plenary.nvim',
  },
  lazy = {
    "neogit",
    cmd = 'Neogit',
    keys = {
      {
        '<leader>gg',
        "<cmd>Neogit<cr>",
        desc = 'Neogit',
      },
      {
        '<leader>gl',
        "<cmd>NeogitLogCurrent<cr>",
        desc = "Log of current file"
      }
    },
    after = function()
      require('neogit').setup({
        commit_editor = {
          show_staged_diff = false, -- INFO: Disabled because this freezes neogit for very large commits
        }
      })
    end
  }
}
