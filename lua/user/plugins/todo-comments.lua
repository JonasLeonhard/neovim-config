return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = { 'BufReadPost', 'BufNewFile' },
  config = function(_, opts)
    require('todo-comments').setup(opts)
  end,
}
