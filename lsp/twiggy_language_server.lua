return {
  cmd = { 'twiggy-language-server', '--stdio' },
  filetypes = { 'twig' },
  root_dir = vim.fs.root(0, { 'composer.json', '.git' })
}
