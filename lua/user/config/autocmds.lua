-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'YankHighlight' }
  end,
  group = highlight_group,
  pattern = '*',
})
vim.cmd [[highlight YankHighlight guifg=#000000 guibg=#FAB387 gui=nocombine]]

-- enable syntax
vim.api.nvim_create_autocmd('BufEnter', {
  command = 'syntax on', -- syntax_on/syntax does not work for some reason
})

vim.api.nvim_create_autocmd('BufEnter', {
  command = 'stopinsert', -- fix telescope opening files in insert mode
})
