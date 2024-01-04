return {
  'echasnovski/mini.files',
  version = false,
  lazy = true,
  keys = {
    {
      '<leader><C-e>',
      "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",
      desc = 'Files mini (current File)',
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
