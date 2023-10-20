local function list_registered_null_ls_providers_names(filetype)
  local null_sources = require 'null-ls.sources'
  local available_sources = null_sources.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    table.insert(registered, source.name)
  end
  return vim.fn.uniq(registered)
end

return {
  'linrongbin16/lsp-progress.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'nvimtools/none-ls.nvim' },
  opts = {
    format = function(messages)
      local active_clients = vim.lsp.get_clients { bufnr = 0 }

      if #messages > 0 then
        return '󱙋 :' .. table.concat(messages, ' ')
      end

      if #active_clients <= 0 then
        return ''
      end

      local client_names = {}
      for i, client in ipairs(active_clients) do
        if client and client.name ~= '' and client.name ~= 'null-ls' then
          table.insert(client_names, client.name)
        end
      end

      local supported_formatters = list_registered_null_ls_providers_names(vim.bo.filetype)
      vim.list_extend(client_names, supported_formatters)

      return '󱙋 : ' .. '[' .. table.concat(client_names, ',') .. ']'
    end,
  },
}
