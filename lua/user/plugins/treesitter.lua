return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'vrischmann/tree-sitter-templ'
    },
    event = 'VeryLazy',
    lazy = true,
    opts = {
      additional_vim_regex_highlighting = true,
      ensure_installed = { 'go', 'lua', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim', 'regex', 'bash', 'markdown_inline',
        'markdown' },
      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
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
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ['g]m'] = '@function.outer',
            ['g]]'] = '@class.outer',
          },
          goto_next_end = {
            ['g]M'] = '@function.outer',
            ['g]['] = '@class.outer',
          },
          goto_previous_start = {
            ['g[m'] = '@function.outer',
            ['g[['] = '@class.outer',
          },
          goto_previous_end = {
            ['g[M'] = '@function.outer',
            ['g[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>cSa'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>cSA'] = '@parameter.inner',
          },
        },
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
          config = {
            twig = '{# %s #}',
          },
        },
      },
    },
    build = ':TSUpdate',
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      vim.cmd('doautocmd User TreesitterLoaded')
    end,
  },
}
