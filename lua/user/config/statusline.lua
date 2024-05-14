local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
    mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
    mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
    mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
    mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
    mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return update_mode_colors() .. string.format(" %s ", modes[current_mode]):upper() .. "%#StatusLineNormal#"
end

local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
    return ""
  end

  return string.format("%%<%s/", fpath)
end

local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
    return ""
  end
  return "%#Normal#" .. fname .. "%#StatusLineNormal#"
end

local git = function()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return {
      head = "",
      added = "",
      changed = "",
      removed = ""
    }
  end
  local added = git_info.added and ("%#GitSignsAdd#+" .. git_info.added .. " ") or ""
  local changed = git_info.changed and ("%#GitSignsChange#~" .. git_info.changed .. " ") or ""
  local removed = git_info.removed and ("%#GitSignsDelete#-" .. git_info.removed .. " ") or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end

  return {
    head = "%#StatusLineGit# " .. git_info.head .. ":%#StatusLineNormal#",
    added = added,
    changed = changed,
    removed = removed
  };
end

local function lsp_diagnostics()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#LspDiagnosticsSignError# " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#LspDiagnosticsSignHint#󰙎 " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#LspDiagnosticsSignInformation# " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function macro_recording() -- Macro recording register
  local register = vim.fn.reg_recording()
  if register ~= '' then
    return string.format('recording @ %s - to stop recording press q again. ', register)
  end

  return ''
end

local formatter_list_cache = {}
local function list_formatters()
  if not _AutoFormatEnabled() then
    return '󰉶 : --off '
  end

  local filetype = vim.bo.filetype
  if formatter_list_cache[filetype] then
    return formatter_list_cache[filetype]
  end

  local ok, conform = pcall(require, 'conform')
  local mok, mason_registry = pcall(require, 'mason-registry')


  if (not ok or not mok) then
    formatter_list_cache[filetype] = ''
    return formatter_list_cache[filetype]
  end

  local formatters = conform.list_formatters(0)

  if not formatters then
    formatter_list_cache[filetype] = ''
    return formatter_list_cache[filetype]
  end

  if #formatters == 0 then
    formatter_list_cache[filetype] = ''
    return formatter_list_cache[filetype]
  end

  local names = {}
  for _key, formatter in pairs(formatters) do
    local is_installed = mason_registry.is_installed(formatter.name)
    local name = formatter.name
    if not is_installed then
      name = '󰋗 ' .. name
    end

    table.insert(names, name)
  end

  formatter_list_cache[filetype] = string.format('󰉶 : [%s] ', table.concat(names, ','))
  return formatter_list_cache[filetype]
end

local linter_list_cache = {}
local function list_linters()
  if not _AutoLintEnabled() then
    return '󱔲 : --off '
  end

  local filetype = vim.bo.filetype
  if linter_list_cache[filetype] then
    return linter_list_cache[filetype]
  end

  local ok, lint = pcall(require, 'lint')
  local mok, mason_registry = pcall(require, 'mason-registry')


  if (not ok or not mok) then
    linter_list_cache[filetype] = ''
    return linter_list_cache[filetype]
  end

  local linters = lint._resolve_linter_by_ft(filetype)

  if not linters or #linters == 0 then
    linter_list_cache[filetype] = ''
    return linter_list_cache[filetype]
  end

  local names = {}
  for _, linter in pairs(linters) do
    local is_installed = mason_registry.is_installed(linter)
    local name = linter
    if not is_installed then
      name = string.format('󰋗  %s', name)
    end
    table.insert(names, name)
  end

  linter_list_cache[filetype] = string.format("󱔲 : [%s] ", table.concat(names, ','));
  return linter_list_cache[filetype]
end

local function list_lsps_and_status()
  local ok, lsp_progress = pcall(require, 'lsp-progress')

  if (not ok) then
    return ""
  end

  return string.format(" %s ", lsp_progress.progress());
end

local function filetype()
  return string.format(" %s ", vim.bo.filetype)
end

local function lineinfo()
  return " %l:%c "
end

------------------------- StatusLine -----------------------------------------------------------------
Statusline = {}

Statusline.active = function()
  local git_info = git();

  return table.concat {
    "%#StatusLineNormal#",
    mode(),
    git_info.head,
    filepath(),
    filename(),
    " ",
    git_info.added,
    git_info.changed,
    git_info.removed,
    lsp_diagnostics(),
    "%=%#StatusLineNormal#", -- right side align
    macro_recording(),
    list_lsps_and_status(),
    list_formatters(),
    list_linters(),
    filetype(),
    lineinfo(),
  }
end

vim.cmd([[
  augroup Statusline
  au!
  au WinEnter,BufEnter,WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.active()
  augroup END
]], false)
