return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = { 'BufReadPost', 'BufNewFile' },
  lazy = true,
  config = function(_, opts)
    require('todo-comments').setup(opts)
  end,
}
