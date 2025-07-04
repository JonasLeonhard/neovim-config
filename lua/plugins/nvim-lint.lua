local autolint_on = true

vim.api.nvim_create_user_command('ToggleAutoLint', function()
  autolint_on = not autolint_on

  if not autolint_on then
    vim.diagnostic.reset()
  end

  vim.api.nvim_command 'doautocmd User ToggleAutoLint'
end, {})

_AutoLintEnabled = function()
  return autolint_on
end

return {
  pack = {
    src = 'https://github.com/mfussenegger/nvim-lint',
  },
  lazy = {
    "nvim-lint",
    event = "DeferredUIEnter",
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
    after = function()
      local lint = require 'lint'

      -- custom linter configs:
      lint.linters.djlint.args = {
        '--linter-output-format',
        '{line}:{code}: {message}',
        '--profile',
        'nunjucks',
        '--preserve-blank-lines',
        '--line-break-after-multiline-tag',
        '--indent',
        '2',
        '-',
      }

      -- Setup:
      lint.linters_by_ft = {
        php = { 'phpstan' },
        twig = { 'djlint', 'twigcs' },
      }


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
}
