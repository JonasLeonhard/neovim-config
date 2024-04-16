return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    {
      'L3MON4D3/LuaSnip',
      version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      build = "make install_jsregexp",
      dependencies = { 'rafamadriz/friendly-snippets' },
      opts = {},
      event = 'User FileOpened',
      -- install jsregexp (optional!).
      lazy = true,
    },
    {
      'zbirenbaum/copilot-cmp',
      dependencies = { 'copilot.lua' },
      opts = true
    },
  },
  event = 'VeryLazy',
  lazy = true,
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'

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
        { name = 'copilot',  group_index = 2 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'path',     group_index = 2 },
        { name = 'buffer',   group_index = 2 },
        { name = 'luasnip',  group_index = 2 }
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
            luasnip = '[Snp]',
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
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
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
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
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
          follow_cursor = true
        }
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

    -- Highlight Background:
    vim.cmd 'highlight CMPMenu guibg=#181825'
  end,
}
