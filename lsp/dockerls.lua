return {
  cmd = { 'docker-langserver', '--stdio' },
  filetypes = { 'dockerfile' },
  root_dir = vim.fs.root(0, { 'Dockerfile' }),
}
