vim.api.nvim_create_user_command('ToggleInlayHints', function()
  vim.lsp.inlay_hint(0, nil) -- requires hint to be enabled in lsp config
end, {})
