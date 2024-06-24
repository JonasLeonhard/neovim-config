-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'YankHighlight', priority = 10000 }
  end,
  group = highlight_group,
  pattern = '*',
})
vim.cmd [[highlight YankHighlight guifg=#000000 guibg=#FAB387 gui=nocombine]]

-- @author: astrovim:
-- creates a augroup _file_opened that checks whether a file was opened. (Not alpha dashboard) or other files with no name,
-- and runs the "User FileOpened" automcmd once.
-- this allows plugins to only load once a file was loaded. Not in the dashboard. Increasing the startup time for things like treesitter, wich would normally load in alpha dashboard BufRead, BufWinEnter or BufNewFile
vim.api.nvim_create_augroup('_file_opened', { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufWinEnter', 'BufNewFile' }, {
  group = '_file_opened',
  nested = true,
  callback = function(args)
    local buftype = vim.api.nvim_get_option_value('buftype', { buf = args.buf }) -- special buffers like telescopes 'prompt', or plugin buffers 'nofile', etc.
    local filename = vim.fn.expand '%'
    if filename ~= '' and buftype == '' then
      vim.api.nvim_del_augroup_by_name '_file_opened'
      vim.cmd 'do User FileOpened'
    end
  end,
})
