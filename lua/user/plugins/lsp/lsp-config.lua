return {
  'neovim/nvim-lspconfig',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- INFO: Installation Instruction for lsp's can be found here:
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

    lspconfig.rust_analyzer.setup({
      capabilities = capabilities,
      settings = {
        ['rust-analyzer'] = {
          cargo = { allFeatures = true },
          checkOnSave = {
            command = 'clippy',
          },
        },
      },
    })

    lspconfig.zls.setup({
      capabilities = capabilities,
      settings = {
        enable_build_on_save = true,
        build_on_save_step = 'check',
      },
    })

    lspconfig.gopls.setup({
      capabilities = capabilities,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            enable = true,
            -- enable = false,
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
            },
          },
          telemetry = { enable = false },
          hint = { enable = true },
        },
      },
    })

    lspconfig.intelephense.setup({
      capabilities = capabilities,
    })

    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = os.getenv('HOME') .. '/.config/yarn/global/node_modules/@vue/typescript-plugin',
            languages = { 'javascript', 'typescript', 'vue' },
          },
        },
      },
      filetypes = {
        'javascript',
        'typescript',
        'vue',
        'javascriptreact',
      },
      settings = {
        javascript = {
          inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
        typescript = {
          inlayHints = {
            includeInlayEnumMemberValueHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      },
    })

    lspconfig.eslint.setup({
      capabilities = capabilities,
    })

    lspconfig.html.setup({
      capabilities = capabilities,
      filetypes = {
        'templ',
      },
    })

    lspconfig.svelte.setup({
      capabilities = capabilities
    })

    lspconfig.cssls.setup {
      capabilities = capabilities,
    }

    lspconfig.tailwindcss.setup({
      capabilities = capabilities,
      filetypes = {
        'templ', 'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'django-html', 'edge',
        'eelixir', 'ejs', 'erb', 'eruby', 'gohtml', 'haml', 'handlebars', 'hbs', 'html',
        'html-eex', 'jade', 'leaf', 'liquid', 'markdown', 'mdx', 'mustache', 'njk', 'nunjucks',
        'php', 'razor', 'slim', 'twig', 'css', 'less', 'postcss', 'sass', 'scss', 'stylus',
        'sugarss', 'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript',
        'typescriptreact', 'vue', 'svelte',
      },
      init_options = {
        userLanguages = {
          templ = 'html',
        },
      },
    })

    lspconfig.dockerls.setup({
      capabilities = capabilities,
    })

    lspconfig.jsonls.setup({
      capabilities = capabilities,
    })

    lspconfig.marksman.setup({
      capabilities = capabilities,
    })

    lspconfig.twiggy_language_server.setup({
      capabilities = capabilities,
    })

    lspconfig.nushell.setup({
      capabilities = capabilities,
    })
  end
}
