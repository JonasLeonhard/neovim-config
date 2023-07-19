local autoformatting_on = true

vim.api.nvim_create_user_command('ToggleAutoFormat', function()
  autoformatting_on = not autoformatting_on
end, {})

_AutoFormatEnabled = function()
  return autoformatting_on
end

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    if autoformatting_on then
      vim.lsp.buf.format { async = true }
    end
  end,
})
