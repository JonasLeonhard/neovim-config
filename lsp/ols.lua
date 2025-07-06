return {
  cmd = { 'ols' },
  filetypes = { 'odin' },
  root_dir = vim.fs.root(0, { 'ols.json', '.git', '.odin' }),
  init_options = {
    checker_args = "-strict-style -vet -debug",
  },
}
