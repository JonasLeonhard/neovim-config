local modes = {
  ['n'] = 'NORMAL',
  ['no'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['V'] = 'VISUAL LINE',
  [''] = 'VISUAL BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'SELECT LINE',
  [''] = 'SELECT BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rv'] = 'VISUAL REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'VIM EX',
  ['ce'] = 'EX',
  ['r'] = 'PROMPT',
  ['rm'] = 'MOAR',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = '%#StatusLineAccent#'
  if current_mode == 'n' then
    mode_color = '%#StatuslineAccent#'
  elseif current_mode == 'i' or current_mode == 'ic' then
    mode_color = '%#StatuslineInsertAccent#'
  elseif current_mode == 'v' or current_mode == 'V' or current_mode == '' then
    mode_color = '%#StatuslineVisualAccent#'
  elseif current_mode == 'R' then
    mode_color = '%#StatuslineReplaceAccent#'
  elseif current_mode == 'c' then
    mode_color = '%#StatuslineCmdLineAccent#'
  elseif current_mode == 't' then
    mode_color = '%#StatuslineTerminalAccent#'
  end
  return mode_color
end

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return update_mode_colors() .. string.format(' %s ', modes[current_mode]):upper() .. '%#StatusLineNormal#'
end

local git = function()
  -- check if we have an actual file open, if not, gitsigns is not loaded and we dont want to require it here for startup time reasons
  if vim.bo.filetype == '' then
    return {
      head = '',
      added = '',
      changed = '',
      removed = '',
    }
  end

  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == '' then
    return {
      head = '',
      added = '',
      changed = '',
      removed = '',
    }
  end
  local added = git_info.added and ('%#GitSignsAdd#+' .. git_info.added .. ' ') or ''
  local changed = git_info.changed and ('%#GitSignsChange#~' .. git_info.changed .. ' ') or ''
  local removed = git_info.removed and ('%#GitSignsDelete#-' .. git_info.removed .. ' ') or ''
  if git_info.added == 0 then
    added = ''
  end
  if git_info.changed == 0 then
    changed = ''
  end
  if git_info.removed == 0 then
    removed = ''
  end

  return {
    head = '%#StatusLineGit# ' .. git_info.head .. ':%#StatusLineNormal#',
    added = added,
    changed = changed,
    removed = removed,
  }
end

local function lsp_diagnostics()
  -- check if we have an actual file open, if not, lsp is not loaded and we dont want to require it here for startup time reasons
  if vim.bo.filetype == '' then
    return ''
  end

  -- Get the diagnostic counts for the current buffer
  local diagnostic_counts = vim.diagnostic.count(0, {})

  -- Initialize diagnostic strings
  local errors = ''
  local warnings = ''
  local info = ''
  local hints = ''

  -- Map the diagnostic severity to the appropriate icon and color
  if diagnostic_counts[vim.diagnostic.severity.ERROR] and diagnostic_counts[vim.diagnostic.severity.ERROR] > 0 then
    errors = ' %#LspDiagnosticsSignError# ' .. diagnostic_counts[vim.diagnostic.severity.ERROR]
  end
  if diagnostic_counts[vim.diagnostic.severity.WARN] and diagnostic_counts[vim.diagnostic.severity.WARN] > 0 then
    warnings = ' %#LspDiagnosticsSignWarning# ' .. diagnostic_counts[vim.diagnostic.severity.WARN]
  end
  if diagnostic_counts[vim.diagnostic.severity.INFO] and diagnostic_counts[vim.diagnostic.severity.INFO] > 0 then
    info = ' %#LspDiagnosticsSignInformation# ' .. diagnostic_counts[vim.diagnostic.severity.INFO]
  end
  if diagnostic_counts[vim.diagnostic.severity.HINT] and diagnostic_counts[vim.diagnostic.severity.HINT] > 0 then
    hints = ' %#LspDiagnosticsSignHint#󰙎 ' .. diagnostic_counts[vim.diagnostic.severity.HINT]
  end

  -- Concatenate and return the diagnostic strings
  return errors .. warnings .. hints .. info .. '%#Normal#'
end

local function macro_recording(is_recording_leave)
  if is_recording_leave then -- we have to manually check if we are called in the RecordingLeave autocmd, because RecordingLeave does not update reg_recording immediatly
    return ''
  end

  local register = vim.fn.reg_recording()
  if register ~= '' then
    return string.format('recording @ %s - to stop recording press q again. ', register)
  end

  return ''
end

local formatter_list_cache = {}
local function list_formatters()
  -- check if we have an actual file open, if not, formatters are not loaded and we dont want to require it here for startup time reasons
  if vim.bo.filetype == '' then
    return ''
  end

  local ok, enabled = pcall(_AutoFormatEnabled, nil)
  if not ok or not enabled then
    return '󰉶 : --off '
  end

  local filetype = vim.bo.filetype
  if formatter_list_cache[filetype] then
    return formatter_list_cache[filetype]
  end

  local ok, conform = pcall(require, 'conform')
  local mok, mason_registry = pcall(require, 'mason-registry')

  if not ok or not mok then
    formatter_list_cache[filetype] = ''
    return formatter_list_cache[filetype]
  end

  local formatters = conform.list_formatters(0)

  if not formatters or #formatters == 0 then
    formatter_list_cache[filetype] = ''
    return formatter_list_cache[filetype]
  end

  local names = {}
  for _, formatter in pairs(formatters) do
    local is_installed = mason_registry.is_installed(formatter.name)
    if is_installed then
      table.insert(names, formatter.name)
    end
  end

  formatter_list_cache[filetype] = string.format('󰉶 : [%s] ', table.concat(names, ','))

  return formatter_list_cache[filetype]
end

local linter_list_cache = {}
local function list_linters()
  -- check if we have an actual file open, if not, linters are not loaded and we dont want to require it here for startup time reasons
  if vim.bo.filetype == '' then
    return ''
  end

  local ok, enabled = pcall(_AutoLintEnabled, nil)
  if not ok or not enabled then
    return '󱔲 : --off '
  end

  local filetype = vim.bo.filetype
  if linter_list_cache[filetype] then
    return linter_list_cache[filetype]
  end

  local ok, lint = pcall(require, 'lint')
  local mok, mason_registry = pcall(require, 'mason-registry')

  if not ok or not mok then
    linter_list_cache[filetype] = ''
    return linter_list_cache[filetype]
  end

  local linters = lint._resolve_linter_by_ft(filetype)

  local names = {}
  for _, linter in pairs(linters) do
    local is_installed = mason_registry.is_installed(linter)
    if not is_installed then
      table.insert(names, linter)
    end
  end

  if #names == 0 then
    linter_list_cache[filetype] = ''
    return linter_list_cache[filetype]
  end

  linter_list_cache[filetype] = string.format('󱔲 : [%s] ', table.concat(names, ','))
  return linter_list_cache[filetype]
end

local cached_lsp_list = nil
local escape = function(text)
  -- Escape special characters for statusline
  return text:gsub('%%', '%%%%') -- Escape percentage signs
end

local function lsp_progress(event)
  local display = '󱙋 : '

  -- display report if given
  if event and event.file == 'report' then
    if event.data.params.value.title then
      display = display .. escape(tostring(event.data.params.value.title))
    end

    if event.data.params.value.message then
      display = display .. ' ' .. escape(tostring(event.data.params.value.message))
    end

    if event.data.params.value.percentage then
      display = display .. ' ' .. escape(tostring(event.data.params.value.percentage)) .. '%%%% '
    end
    return display
  end

  -- else we display the lsp list
  if cached_lsp_list then
    return cached_lsp_list
  end

  local clients = vim.lsp.get_clients { bufnr = 0 }
  local client_names = {}

  for _, client in ipairs(clients) do
    table.insert(client_names, client.name) -- or use client.id for the ID
  end

  if #clients == 0 then
    display = ''
  else
    display = display .. '[' .. table.concat(client_names, ',') .. ']'
  end

  -- cache the client list
  cached_lsp_list = display .. ' '
  return cached_lsp_list
end

------------------------- StatusLine -----------------------------------------------------------------
Statusline = {}

Statusline.render = function(lsp_progress_event, is_recording_leave)
  local git_info = git()

  vim.o.statusline = table.concat {
    '%#StatusLineNormal#',
    mode(),
    git_info.head,
    '%{expand("%:.:h")}/', -- filedir path + /
    '%#Normal#',
    '%t', -- filename
    '%#StatusLineNormal#',
    ' ',
    git_info.added,
    git_info.changed,
    git_info.removed,
    lsp_diagnostics(),
    '%=%#StatusLineNormal#', -- right side align
    macro_recording(is_recording_leave),
    lsp_progress(lsp_progress_event),
    list_formatters(),
    list_linters(),
    ' : %y', -- [filetype]
    ' %l:%c ', -- line:column
  }
end

Statusline.clear_lsp_cache_and_render = function()
  cached_lsp_list = nil
  Statusline.render()
end

-- Example of how to use the cached filepath in the status line
Statusline.render()

-- Autocmds, when to redraw the statusline
vim.cmd [[
  augroup StatusLineCache
    autocmd!
    autocmd BufWrite,ModeChanged,RecordingEnter * lua Statusline.render()
  augroup END
]]

vim.cmd [[
  augroup StatusLineCache2
    autocmd!
    autocmd RecordingLeave * lua Statusline.render(nil, true) -- reg_recording is only updated after RecordingLeave. So we have to pass that we're leaving manually
  augroup END
]]

-- We dont want to use the cached lsp here
vim.cmd [[
  augroup StatusLineCache3
    autocmd!
    autocmd BufEnter,BufLeave,LspAttach,LspDetach * lua Statusline.clear_lsp_cache_and_render()
  augroup END
]]

vim.api.nvim_create_autocmd('LspProgress', {
  callback = function(lsp_progress_event)
    Statusline.render(lsp_progress_event)
  end,
})

-- dispatched via vim.api.nvim_command 'doautocmd User AutoFormatToggled'
vim.api.nvim_create_autocmd('User', {
  pattern = 'AutoFormatToggled',
  callback = function()
    Statusline.render()
  end,
})

vim.api.nvim_create_autocmd('User', {
  pattern = 'ToggleAutoLint',
  callback = function()
    Statusline.render()
  end,
})
