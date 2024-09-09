-- This file is automatically loaded by init.lua, find more info for options via ':h <option>'

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local opt = vim.opt

opt.smartindent = true -- smartly indent new lines
opt.breakindent = true -- keep same indentation after break
opt.autowrite = true -- Enable auto write
opt.clipboard = 'unnamedplus' -- Sync with system clipboard
opt.completeopt = 'menu,menuone,noselect'
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = 'jcroqlnt' -- tcqj
opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.ignorecase = true -- Ignore case
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { 'en' }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = 'screen'
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

opt.laststatus = 3
opt.ch = 0 -- no cmdheight
opt.nrformats = 'bin,hex,alpha,octal,'

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

require 'user.config.autocmds'
require 'user.config.listchars'
require 'user.config.diagnostics'
require 'user.config.formatting'
require 'user.config.terminal'
require 'user.config.inlayHints'
require 'user.config.fold'
require 'user.config.nushell'
require 'user.config.statusline'

-- info: this creates a detailed flamegraph profiler using plenary plugin. You can copy paste this to profile performance issues
-- create a detailed profile logs as flamegraph: https://www.speedscope.app/

-- vim.api.nvim_create_user_command("ProfileStart", function()
--   require("plenary.profile").start(("profile-%s.log"):format(vim.version()), { flame = true })
-- end, {})

-- vim.api.nvim_create_user_command("ProfileStop", require("plenary.profile").stop, {})

-- put :messages in a new buffer
vim.api.nvim_command 'command! Messages enew | execute "redir @a" | silent messages | redir END | normal! "ap'

-- Netrw - keybinds + custom toggle function
_G.Netrw_create_file = function()
  local file_name = vim.fn.input 'Enter new file name: '

  if file_name ~= '' then
    local current_dir = vim.fn.expand '%:p:h'
    local file_path = current_dir .. '/' .. file_name
    if vim.fn.filereadable(file_path) == 1 then
      print('File already exists: ' .. file_path)
    else
      vim.fn.writefile({}, file_path)
      vim.cmd('edit ' .. current_dir) -- Refresh
    end

    -- Refresh
    vim.cmd('edit ' .. current_dir)
  else
    print 'File name cannot be empty'
  end
end
vim.cmd 'autocmd FileType netrw nnoremap ? :help netrw-quickmap<CR>'
vim.cmd 'autocmd FileType netrw nnoremap <silent> f :lua Netrw_create_file()<CR>'
