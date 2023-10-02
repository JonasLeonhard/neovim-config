-- folding
vim.o.foldcolumn = '1'
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldmethod = 'expr'
vim.opt.fillchars:append({ fold = " ", foldopen = "+", foldsep = "│", foldclose = "-" })

vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldtext = 'v:lua.vim.treesitter.foldtext()'

-- after treesitter is loaded in treesitter.lua this gets called, as folds do not update on inital load otherwise
vim.api.nvim_create_autocmd('User TreesitterLoaded', {
  command = 'set foldexpr=v:lua.vim.treesitter.foldexpr()',
})
