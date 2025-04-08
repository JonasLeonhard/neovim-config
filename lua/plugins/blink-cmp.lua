return {
  'saghen/blink.cmp',
  event = { "VeryLazy" },
  lazy = true,      -- lazy loading handled internally... but this is still faster in my measurements
  version = 'v0.*', -- use a release tag to download pre-built binaries
  opts = function()
    local showCmp = function(cmp)
      if cmp.is_menu_visible() then
        cmp.hide()
        cmp.hide_signature()
      else
        cmp.show()
        cmp.show_signature()
      end
      return true
    end

    return {
      keymap = {
        preset = "none",
        ['<C-x>'] = { showCmp },
        ['<C-space>'] = { showCmp },
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
        },
        menu = { auto_show = false }
      },
      signature = {
        enabled = true,
        trigger = {
          enabled = true,
          show_on_keyword = false,
          show_on_trigger_character = false,
          show_on_insert = false,
          show_on_insert_on_trigger_character = false,
        }
      },
    }
  end
}
