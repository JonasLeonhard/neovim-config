--- This file adds custom highlighting for specific listchars in red, for example NonBreakingSpace and TralingSpaceChar
local themeColors = {
  red = "#F38BA8"
}

-- highlight listchars (non whitespace, trailing whitespace, tab) :h listchars :h list
vim.opt.listchars = "tab:  ,trail:·,nbsp:·"

local highlightListchars = function()
  local filename = vim.fn.expand('%');

  -- skip highlighting for non-files (eg- alpha dashboard.)
  if (filename == '' or vim.bo.buftype == 'terminal' or vim.bo.buftype == 'nofile') then
    return
  end

  -- https://vim.fandom.com/wiki/Highlight_unwanted_spaces#Highlighting_with_the_match_command
  vim.cmd [[ syntax match NBSP " " ]] -- <-- INFO: this is a unicode nbsp character
  vim.cmd [[ syntax match TrailingSpaceChar /\s\+$/ ]]
  vim.api.nvim_set_hl(0, "NBSP",
    { fg = "White", bg = themeColors.red })
  vim.api.nvim_set_hl(0, "TrailingSpaceChar",
    { fg = "White", bg = themeColors.red })
end


local deHighlightListchars = function()
  -- https://vim.fandom.com/wiki/Highlight_unwanted_spaces#Highlighting_with_the_match_command
  vim.api.nvim_set_hl(0, "NBSP", {})
  vim.api.nvim_set_hl(0, "TrailingSpaceChar", {})
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = highlightListchars
})

vim.api.nvim_create_autocmd("InsertEnter", {
  callback = deHighlightListchars
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = highlightListchars
})
