return {
  cmd = { 'nu', '--lsp' },
  filetypes = { 'nu' },
  root_dir = vim.fs.root(0, { '.git' })
}
