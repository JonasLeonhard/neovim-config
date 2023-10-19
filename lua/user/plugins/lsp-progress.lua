return {
  'linrongbin16/lsp-progress.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    format = function(messages)
      local active_clients = vim.lsp.get_clients { bufnr = 0 }

      if #messages > 0 then
        return "󱙋 :" .. table.concat(messages, " ")
      end

      if #active_clients <= 0 then
        return ""
      end

      local client_names = {}
      for i, client in ipairs(active_clients) do
        if client and client.name ~= "" then
          table.insert(client_names, client.name)
        end
      end
      return "󱙋 : "
          .. "["
          .. table.concat(client_names, ",")
          .. "]"
    end,
  }
}
