local disable_func = function(_lang, buf)
  local max_line_width = 500

  -- Check first line width
  local first_line = vim.api.nvim_buf_get_lines(buf, 0, 1, false)[1]
  if first_line and #first_line > max_line_width then
    return true
  end
end

return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      {
        'windwp/nvim-ts-autotag',
        event = 'InsertEnter',
        lazy = true,
        opts = {},
      }
    },
    event = 'VeryLazy',
    lazy = true,
    opts = {
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
    },
    build = ':TSUpdate',
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
