local helper = require 'helper'
local pack_specs, lazy_specs = helper.load_plugin_specs()

-- Install plugins using ':h vim.pack':
-- We tell vim.pack to install all the plugins we gathered from /lua/plugins
vim.pack.add(pack_specs, { load = false }) -- If you want to update plugins: ':h vim.pack' or update via ":= vim.pack.update()", :w the buffer to confirm updates

-- Configure builtin neovim options (line number, folds, diagnostics, helpers, lsp's…)
require 'options'
require 'listchars'
require 'nushell'
require 'lsp'

-- Some Plugins don't need to be loaded when we open nvim, as loading them would cause a slight delay when opening.
-- We can instead lazy load them on events. Eg. when going to insert mode, when pressing a key to open the plugins windows, or after neovim has opened.
-- To do this we use the lz.n plugin, which then lazyloads all other plugins after
-- https://github.com/nvim-neorocks/lz.n
require("lz.n").load(lazy_specs)
