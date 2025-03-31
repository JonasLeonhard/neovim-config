-- LazyLoad all lsp/ server configurations
local lsp_configs = {}
for _, v in ipairs(vim.api.nvim_get_runtime_file('lsp/*', true)) do
  local name = vim.fn.fnamemodify(v, ':t:r');
  table.insert(lsp_configs, name)
end

-- For some reason this casues lag:
-- vim.lsp.enable(lsp_configs)
-- -> So we manually setup filetype autocmds

-- eg: { 'lua': { 'lua_ls' }, 'javascript': { 'eslint', 'ts_ls'}}
local filetype_to_servers = {}
for _, server_name in pairs(lsp_configs) do
  local config = vim.lsp.config[server_name]
  if config and config.filetypes then
    for _, ft in pairs(config.filetypes) do
      filetype_to_servers[ft] = filetype_to_servers[ft] or {}
      table.insert(filetype_to_servers[ft], server_name)
    end
  end
end

for ft, servers in pairs(filetype_to_servers) do
  vim.api.nvim_create_autocmd("FileType", {
    pattern = ft,
    callback = function()
      for _, server in pairs(servers) do
        vim.schedule(function()
          vim.lsp.start(vim.lsp.config[server])
        end)
      end
    end
  })
end

vim.api.nvim_create_user_command('LspRestart', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })

  for _, client in ipairs(clients) do
    vim.api.nvim_create_autocmd("LspDetach", {
      once = true,
      callback = function(args)
        if args.data and args.data.client_id == client.id then
          vim.notify("Restarting LSP: " .. client.name, vim.log.levels.INFO)
          vim.lsp.start(vim.lsp.config[client.name], {
            bufnr = bufnr,
            reuse_client = function()
              return false
            end
          })
        end
      end
    })

    vim.notify("Stop LSP: " .. client.name, vim.log.levels.INFO)
    client.stop()
  end
end, {
  desc = "Restart all LSP clients attached to the current buffer"
})

vim.api.nvim_create_user_command('LspLog', function()
  vim.cmd(string.format('tabnew %s', vim.lsp.get_log_path()))
end, {
  desc = 'Opens the Nvim LSP client log.',
})
