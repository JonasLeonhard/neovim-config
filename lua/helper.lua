local M = {}
-- This will create a horizontal split, unless we are in a floating window. Then it creates a tab instead.
-- Why do we need this?
-- Opening a botright split in neogit's logPopup floating window for "limit to files" will cause z-index issues, where the logPopup will be above the fuzzy finder.
-- Opening a split in nvim dap causes other splits to resize. Which is most likely not what we want
M.smart_split = function()
  local open_as_tab = false

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local win_buffer = vim.api.nvim_win_get_buf(win);
    local name = vim.api.nvim_buf_get_name(win_buffer)

    -- Look for dapui buffers which typically have names like "DAP Scopes" or contain "dapui_"
    if name:find("DAP") then
      open_as_tab = true
      break
    end
  end

  local win_config = vim.api.nvim_win_get_config(0)
  if (win_config.relative ~= '') then
    open_as_tab = true
  end

  if open_as_tab then
    vim.cmd('tabnew')
  else
    -- We're in a normal window, do a regular split
    vim.cmd('botright 30split')
  end
end

return M
