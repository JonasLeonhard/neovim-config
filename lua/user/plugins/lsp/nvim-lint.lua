local autolint_on = true

vim.api.nvim_create_user_command('ToggleAutoLint', function()
  autolint_on = not autolint_on

  if not autolint_on then
    vim.diagnostic.reset()
  end
end, {})

_AutoLintEnabled = function()
  return autolint_on
end

return {
  'mfussenegger/nvim-lint',
  lazy = true,
  event = 'User FileOpened',
  keys = {
    {
      '<leader>cl',
      function()
        require('lint').try_lint()
      end,
      desc = 'Lint',
      mode = { 'n' },
    },
  },
  opts = {
    linters_by_ft = {
      lua = { 'luacheck' },
      bash = { 'shellcheck' },
      css = { 'stylelint' },
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      python = { 'mypy', 'pylint' },
      scss = { 'stylelint' },
      sh = { 'shellcheck' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      yaml = { 'yamllint' },
    },
  },
  config = function(_, opts)
    local lint = require 'lint'

    lint.linters_by_ft = opts.linters_by_ft

    local augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      group = augroup,
      callback = function()
        if not _AutoLintEnabled() then
          return
        end
        lint.try_lint(nil, { ignore_errors = true })
      end,
    })
  end,
}
