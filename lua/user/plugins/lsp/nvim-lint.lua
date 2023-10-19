return {
  'mfussenegger/nvim-lint',
  linters_by_ft = {
    lua = { 'luacheck', 'selene' },
    bash = { 'shellcheck' },
    css = { 'stylelint' },
    javascript = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    ['javascript.jsx'] = { 'eslint_d' },
    python = { 'mypy', 'pylint' },
    rst = { 'rstlint' },
    ruby = { 'ruby', 'rubocop' },
    scss = { 'stylelint' },
    sh = { 'shellcheck' },
    typescript = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
    ['typescript.tsx'] = { 'eslint_d' },
    vim = { 'vint' },
    yaml = { 'yamllint' },
  },
  linters = {
    -- selene = {
    --   condition = function(ctx)
    --     return vim.fs.find({ 'selene.toml' }, { path = ctx.filename, upward = true })[1]
    --   end,
    -- },
    -- luacheck = {
    --   condition = function(ctx)
    --     return vim.fs.find({ '.luacheckrc' }, { path = ctx.filename, upward = true })[1]
    --   end,
    -- },
  },
  config = function()
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
