local disable_func = function(lang, buf)
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
      'nvim-treesitter/nvim-treesitter-textobjects',
      {
        "chrisgrieser/nvim-various-textobjs",
        opts = { keymaps = { useDefaults = true } },
      },
    },
    event = 'VeryLazy',
    lazy = true,
    opts = {
      additional_vim_regex_highlighting = false,
      ensure_installed = { 'go', 'lua', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'regex', 'bash', 'markdown_inline',
        'markdown' },
      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = true,
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
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ao"] = "@block.outer",
            ["io"] = "@block.inner",
            ["al"] = "@loop.outer",
            ["il"] = "@loop.inner",
            ["aC"] = "@conditional.outer",
            ["iC"] = "@conditional.inner",
            ["aO"] = "@class.outer",
            ["iO"] = "@class.inner",
            ["aA"] = "@assignment.inner",
            ["aX"] = "@assignment.lhs",
            ["aY"] = "@assignment.rhs",
            ["aG"] = "@comment.outer",
            ["iG"] = "@comment.inner",
            ["an"] = "@number.outer",
            ["in"] = "@number.inner",
            ["ar"] = "@return.outer",
            ["ir"] = "@return.inner",
            ["aR"] = "@regex.outer",
            ["iR"] = "@regex.inner",
            ["as"] = "@statement.outer",
            ["is"] = "@statement.inner",
            ["iS"] = "@scopename.inner",
            ["aS"] = "@scopename.outer",
            ["aP"] = "@parameter.outer",
            ["iP"] = "@parameter.inner",
            ["ia"] = "@attribute.inner",
            ["aa"] = "@attribute.outer",
            ["ac"] = "@call.outer",
            ["ic"] = "@call.inner"
          }
        }
      }
    },
    build = ':TSUpdate',
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      vim.cmd('doautocmd User TreesitterLoaded')
    end,
  },
}
