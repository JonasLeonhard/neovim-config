local disable_func = function(_lang, buf)
  local max_line_width = 500

  -- Check first line width
  local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
  if first_line and #first_line > max_line_width then
    return true
  end
end

return {
  pack = {
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
    { src = 'https://github.com/windwp/nvim-ts-autotag' },
  },
  lazy = {
    'nvim-treesitter',
    event = 'DeferredUIEnter',
    after = function()
      require('nvim-treesitter.configs').setup({
        additional_vim_regex_highlighting = false,
        highlight = {
          enable = true,
          disable = disable_func,
        },
        indent = { enable = true, disable = disable_func },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<CR>',
            node_incremental = '<TAB>',
            scope_incremental = '<CR>',
            node_decremental = '<S-TAB>',
          },
        },
      })

      -- Set up one-time autocmd for autotag setup on InsertEnter
      local autotag_group = vim.api.nvim_create_augroup('TreesitterAutotag', { clear = true })
      vim.api.nvim_create_autocmd('InsertEnter', {
        group = autotag_group,
        once = true, --!
        callback = function()
          require("nvim-ts-autotag").setup()
        end,
      })
    end,
  }
}
