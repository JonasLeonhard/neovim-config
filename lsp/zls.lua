return {
  cmd = { 'zls' },
  filetypes = { 'zig', 'zir' },
  root_dir = vim.fs.root(0, { 'zls.json', 'build.zig', '.git' }),
  settings = {
    enable_build_on_save = true,
    build_on_save_step = 'check',
  },
}
