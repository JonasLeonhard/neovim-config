return {
  'saghen/blink.cmp',
  lazy = false,     -- lazy loading handled internally
  version = 'v0.*', -- use a release tag to download pre-built binaries

  opts = {
    keymap = {
      show = '<C-space>',
      hide = { '<C-q>' },
      accept = '<ENTER>',
      select_prev = '<S-Tab>',
      select_next = '<Tab>',

      show_documentation = {},
      hide_documentation = {},
      scroll_documentation_up = '<C-u>',
      scroll_documentation_down = '<C-d>',

      snippet_forward = '<Tab>',
      snippet_backward = '<S-Tab>',
    },

    trigger = {
      completion = {
        show_on_insert_on_trigger_character = false,
      },
      signature_help = { enabled = true }
    },

    -- experimental auto-brackets support
    accept = { auto_brackets = { enabled = true } },

    sources = {
      providers = {
        {
          { 'blink.cmp.sources.lsp' },
          { 'blink.cmp.sources.path' },
          { 'blink.cmp.sources.buffer' },
          { 'blink.cmp.sources.snippets', score_offset = -3 },
        },
      },
    }
  },
}
