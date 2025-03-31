return {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php' },
  root_dir = vim.fs.root(0, { 'composer.json', '.git' })
}
