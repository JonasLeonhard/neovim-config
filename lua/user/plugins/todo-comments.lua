return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = { 'BufReadPost', 'BufNewFile' },
  lazy = true,
  keys = {
    { '<leader>st', '<cmd>:TodoTelescope<cr>', desc = 'show todo comments' },
  },
  config = function(_, opts)
    require('todo-comments').setup(opts)
  end,
}
