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
        mode = { "n" },
        desc = "Log of current file"
      },
      {
        '<leader>gl',
        function()
          local start_line = vim.fn.line("'<")
          local end_line = vim.fn.line("'>")
          vim.cmd(start_line .. "," .. end_line .. "NeogitLogCurrent")
        end,
        mode = { "v" },
        desc = "Log of current selection"
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
