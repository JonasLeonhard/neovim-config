return {
  'saghen/blink.cmp',
  event = "VeryLazy",
  lazy = true,      -- lazy loading handled internally
  version = 'v0.*', -- use a release tag to download pre-built binaries
  opts = {
    keymap = {
      preset = "enter",
      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },

      ['<C-k>'] = { 'select_prev', 'snippet_backward', 'fallback' },
      ['<C-j>'] = { 'select_next', 'snippet_forward', 'fallback' },

      ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
    },

    completion = {
      documentation = { auto_show = true },
      list = {
        selection = {
          preselect = function(ctx)
            return ctx.mode ~= 'cmdline'
          end
        }
      }
    },
    signature = {
      enabled = true
    },
  },
}
