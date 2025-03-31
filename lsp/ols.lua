return {
  cmd = { 'ols' },
  filetypes = { 'odin' },
  root_dir = vim.fs.root(0, { 'ols.json', '.git', '.odin' })
}
