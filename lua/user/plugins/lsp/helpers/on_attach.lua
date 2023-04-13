local navic_ok, navic = pcall(require, 'nvim-navic')

return function(client, bufnr)
  if navic_ok and client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end
