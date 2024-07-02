return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    {
      'zbirenbaum/copilot-cmp',
      dependencies = { 'copilot.lua' },
      opts = true,
    },
  },
  event = { 'InsertEnter', 'CmdlineEnter' },
  lazy = true,
  config = function()
    local cmp = require 'cmp'

    local kind_icons = {
      Copilot = ' ',
      Class = '',
      Color = '',
      Constant = '',
      Constructor = '',
      Enum = '',
      EnumMember = '',
      Event = '',
      Field = '',
      File = '',
      Folder = '',
      Function = '󰊕',
      Interface = '',
      Keyword = '',
      Method = '',
      Module = '󰕳',
      Operator = '',
      Property = '',
      Reference = '',
      Snippet = '',
      Struct = '',
      Text = '',
      TypeParameter = '',
      Unit = '',
      Value = '',
      Variable = '󰫧',
    }

    cmp.setup {
      window = {
        completion = {
          winhighlight = 'Normal:CMPmenu,FloatBorder:CMPmenu,Search:None',
        },
      },
      sources = {
        { name = 'copilot', group_index = 2 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'path', group_index = 2 },
        { name = 'buffer', group_index = 2 },
        { name = 'nvim_lsp_signature_help' },
        {
          name = 'lazydev',
          group_index = 0, -- set group index to 0 to skip loading LuaLS completions
        },
      },
      formatting = {
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
          -- Source
          vim_item.menu = ({
            copilot = '[Cop]',
            buffer = '[Buf]',
            cmdline = '[Cmd]',
            latex_symbols = '[Ltx]',
            nvim_lsp = '[Lsp]',
            nvim_lua = '[Lua]',
            path = '[Pth]',
          })[entry.source.name]
          return vim_item
        end,
      },
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          vim.snippet.expand(args.body) -- native neovim snippets (Neovim v.0.10+)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-ESC>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm {
          select = false,
        }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif vim.snippet.active { direction = 1 } then
            vim.snippet.jump(1)
          else
            fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active { direction = -1 } then
            vim.snippet.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sorting = {
        priority_weight = 2,
        comparators = {
          require('copilot_cmp.comparators').prioritize,

          -- Below is the default comparitor list and order for nvim-cmp
          cmp.config.compare.offset,
          -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
          cmp.config.compare.exact,
          cmp.config.compare.score,
          cmp.config.compare.recently_used,
          cmp.config.compare.locality,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      view = {
        entries = {
          follow_cursor = true,
        },
      },
    }

    -- Set configuration for specific filetypes.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
      }, {
        { name = 'buffer' },
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })
  end,
}
