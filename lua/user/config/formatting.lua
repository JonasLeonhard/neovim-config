local autoformatting_on = true

vim.api.nvim_create_user_command('ToggleAutoFormat', function()
  autoformatting_on = not autoformatting_on
  vim.api.nvim_command 'doautocmd User AutoFormatToggled'
end, {})

_AutoFormatEnabled = function()
  return autoformatting_on
end
