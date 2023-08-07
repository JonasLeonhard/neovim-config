-- :h terminal

-- Disable line numbers in terminal
vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber signcolumn=no]])
-- Start in insert mode in terminal
vim.cmd([[autocmd TermOpen * startinsert]])

-- ------------------- Keymaps ----------------------------------
function _Set_terminal_keymaps()
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], { buffer = 0 })
end

vim.cmd 'autocmd! TermOpen term://* lua _Set_terminal_keymaps()'

-- Automatically close terminal window when one of the following commands exits:
-- close after LazyDocker
vim.cmd([[autocmd TermClose *:lazyDocker exe 'bdelete! '..expand('<abuf>')]])
