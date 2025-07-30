local M = {}

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
