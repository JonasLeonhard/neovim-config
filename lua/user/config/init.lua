-- This file is automatically loaded by init.lua, find more info for options via ':h <option>'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt

opt.synmaxcol = 500            -- disable "set syntax" for large files for better performance
opt.smartindent = true         -- smartly indent new lines
opt.breakindent = true         -- keep same indentation after break
opt.autowrite = true           -- Enable auto write
opt.clipboard = 'unnamedplus'  -- Sync with system clipboard
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 2           -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true             -- Confirm to save changes before exiting modified buffer
opt.cursorline = true          -- Enable highlighting of the current line
opt.expandtab = true           -- Use spaces instead of tabs
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.ignorecase = true      -- Ignore case
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.list = true            -- Show some invisible characters (tabs...
opt.mouse = 'a'            -- Enable mouse mode
opt.number = true          -- Print line number
opt.pumblend = 10          -- Popup blend
opt.pumheight = 10         -- Maximum number of entries in a popup
opt.relativenumber = true  -- Relative line numbers
opt.scrolloff = 4          -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
opt.shiftround = true      -- Round indent
opt.shiftwidth = 2         -- Size of an indent
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.showmode = false       -- Dont show mode since we have a statusline
opt.sidescrolloff = 8      -- Columns of context
opt.signcolumn = 'yes'     -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true       -- Don't ignore case with capitals
opt.smartindent = true     -- Insert indents automatically
opt.spelllang = { 'en' }
opt.splitbelow = true      -- Put new windows below current
opt.splitkeep = 'screen'
opt.splitright = true      -- Put new windows right of current
opt.tabstop = 2            -- Number of spaces tabs count for
opt.termguicolors = true   -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200               -- Save swap file and trigger CursorHold
opt.virtualedit = 'block'          -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.wrap = false                   -- Disable line wrap

opt.laststatus = 3
opt.nrformats = 'bin,hex,alpha,octal,'

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Folding
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.foldmethod = 'manual' -- for treesitter / lsp folding, the rest of ufo gets used

-- Filetype's:
vim.filetype.add({
  extension = {
    svx = "markdown"
  }
})

-- Diagnostic's:
vim.diagnostic.config {
  float = {
    source = true,
  },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = '󰋼 ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },
  underline = true,
  update_in_insert = false,
  virtual_text = {
    prefix = ' ', -- icon for diagnostic message
  },
}

-- Command's: --------------------------------------------------------------------------------------------------

-- Messages command: put :messages in a new buffer
vim.api.nvim_command 'command! Messages enew | execute "redir @a" | silent messages | redir END | normal! "ap'

-- Only Command: same as :only , but for floating windows
vim.api.nvim_create_user_command('Only', function()
  local win_id = vim.api.nvim_get_current_win()
  local config = vim.api.nvim_win_get_config(win_id)

  if config.relative ~= '' then -- if floating window
    local floating_buf = vim.api.nvim_win_get_buf(win_id)
    vim.api.nvim_win_close(win_id, false)
    vim.cmd('enew | silent! only')
    if (vim.api.nvim_buf_is_valid(floating_buf)) then
      vim.api.nvim_win_set_buf(0, floating_buf)
    end
  end
end, {})

-- ToggleAutoFormat command
local autoformatting_on = true

vim.api.nvim_create_user_command('ToggleAutoFormat', function()
  autoformatting_on = not autoformatting_on
  vim.api.nvim_command 'doautocmd User AutoFormatToggled'
end, {})

_AutoFormatEnabled = function()
  return autoformatting_on
end

vim.api.nvim_create_user_command('ToggleInlayHints', function()
  vim.lsp.inlay_hint(0, nil) -- requires hint to be enabled in lsp config
end, {})


-- Autocmd's:
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

-- Terminal config:
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

require 'user.config.listchars'
require 'user.config.nushell'
require 'user.config.fuzzy'
