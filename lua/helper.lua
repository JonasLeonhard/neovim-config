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


-- Loads all /lua/plugins tables an seperates their content into pack => pack_specs, lazy => lazy_specs
M.load_plugin_specs = function()
  local pack_specs = {}
  local lazy_specs = {}
  local plugins_dir = vim.fn.stdpath("config") .. "/lua/plugins"
  local files = vim.fn.glob(plugins_dir .. "/*.lua", false, true)
  for _, file in ipairs(files) do
    local ok, spec = pcall(dofile, file)
    if ok and type(spec) == "table" then
      -- Handle pack as array or single item
      if spec.pack then
        if type(spec.pack) == "table" and spec.pack[1] then
          -- pack is an array
          for _, pack_item in ipairs(spec.pack) do
            table.insert(pack_specs, pack_item)
          end
        else
          -- pack is a single item
          table.insert(pack_specs, spec.pack)
        end
      end

      -- Handle lazy as array or single item
      if spec.lazy then
        table.insert(lazy_specs, spec.lazy)
      end
    end
  end
  return pack_specs, lazy_specs
end

return M
