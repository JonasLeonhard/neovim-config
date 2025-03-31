return {
  cmd = { 'svelteserver', '--stdio' },
  filetypes = { 'svelte' },
  root_markers = vim.fs.root(0, { 'package.json', '.git' })
}
