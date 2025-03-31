return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_dir = vim.fs.root(0, { 'Cargo.toml', '.git' }),
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true,
      },
      checkOnSave = true,
      check = {
        enable = true,
        command = 'clippy',
        features = 'all',
      },
      procMacro = {
        enable = true,
      },
    }
  }

}
