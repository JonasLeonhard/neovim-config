return {
  'saghen/blink.cmp',
  lazy = false,     -- lazy loading handled internally
  version = 'v0.*', -- use a release tag to download pre-built binaries
  opts = {
    keymap = {
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<Tab>'] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        'snippet_forward',
        'fallback'
      },
      ['<S-Tab>'] = { 'snippet_backward', 'fallback' },

      ['<C-k>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<C-j>'] = { 'select_next', 'snippet_forward', 'fallback' },

      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },

    completion = {
      documentation = { auto_show = true },
    },
    signature = {
      enabled = true
    },


    sources = {
      providers = {
        lsp = {
          module = 'blink.cmp.sources.lsp',
          name = 'LSP',
          score_offset = 999,
        },
        buffer = {
          module = 'blink.cmp.sources.buffer',
          name = 'Buffer',
          score_offset = 0
        },
        path = {
          module = 'blink.cmp.sources.path',
          name = 'Path',
          score_offset = -3
        },
        snippets = {
          module = 'blink.cmp.sources.snippets',
          name = 'Snippets',
          score_offset = -3
        },
      },
    }
  },
}
