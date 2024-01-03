return {
  'echasnovski/mini.files',
  version = false,
  keys = {
    {
      '<leader><C-e>',
      "<cmd>e %:h<cr>",
      desc = 'Files mini (current File)',
    },
    {
      '<leader><C-E>',
      "<cmd>e .<cr>",
      desc = 'Files mini (root)',
    }
  },
  opts = {
    options = {
      permanent_delete = false,
    },
    windows = {
      preview = true,
    }
  }
}
