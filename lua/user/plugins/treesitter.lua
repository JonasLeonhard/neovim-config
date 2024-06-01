return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
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
    },
    build = ':TSUpdate',
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      vim.cmd('doautocmd User TreesitterLoaded')
    end,
  },
}
