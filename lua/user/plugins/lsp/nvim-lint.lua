return {
  'mfussenegger/nvim-lint',
  lazy = true,
  event = 'User FileOpened',
  opts = {
    linters_by_ft = {
      lua = { 'luacheck' },
      bash = { 'shellcheck' },
      css = { 'stylelint' },
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      ['javascript.jsx'] = { 'eslint_d' },
      python = { 'mypy', 'pylint' },
      scss = { 'stylelint' },
      sh = { 'shellcheck' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      ['typescript.tsx'] = { 'eslint_d' },
      yaml = { 'yamllint' },
    },
    linters = { -- extends linters[name] if exists
      -- luacheck = {
      --   condition = function(ctx)
      --     return vim.fs.find({ '.luacheckrc' }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
    },
  },
  config = function(_, opts)
    local lint = require 'lint'

    for name, linter in pairs(opts.linters) do
      if type(linter) == 'table' and type(lint.linters[name]) == 'table' then
        lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], linter)
      else
        lint.linters[name] = linter
      end
    end

    lint.linters_by_ft = opts.linters_by_ft

    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave' }, {
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
