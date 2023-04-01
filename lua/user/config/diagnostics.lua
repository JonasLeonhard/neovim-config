vim.diagnostic.config({
  float = {
    format = function(diagnostic)
      local code = diagnostic.user_data.lsp.code

      if not diagnostic.source or not code then
        return string.format('%s', diagnostic.message)
      end

      return string.format('[%s]: %s', diagnostic.source, diagnostic.message)
    end
  },
  severity_sort = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  virtual_text = {
    prefix = ' ', -- icon for diagnostic message
  },
})
