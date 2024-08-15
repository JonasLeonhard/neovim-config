return {
  {
    'RRethy/vim-illuminate',
    event = { 'BufReadPost', 'BufNewFile' },
    lazy = true,
    keys = {
      {
        'gi',
        function()
          require('illuminate').goto_next_reference()
        end,
        desc = 'Go to next underlined reference (illiminate)',
        mode = 'n',
      },
      {
        'gI',
        function()
          require('illuminate').goto_prev_reference()
        end,
        desc = 'Go to pref underlined reference (illiminate)',
        mode = 'n',
      },
    },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = { 'lsp' },
      },
    },
    config = function(_, opts)
      require('illuminate').configure(opts)
    end,
  },
}
