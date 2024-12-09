return {
  'neovim/nvim-lspconfig',
  lazy = true,
  event = 'VeryLazy',
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    -- i had performance issues (nvim was frozen) when using lspconfig.rust_analyzer.setup({...}) directly.
    local setup_lsp = function(server, config)
      vim.schedule(function()
        server.setup(config);
        vim.cmd('LspStart')
      end)
    end

    -- INFO: Installation Instruction for lsp's can be found here:
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
    setup_lsp(lspconfig.rust_analyzer, {
      {
        capabilities = capabilities,
        filetypes = { "rust" },
        settings = {
          ['rust-analyzer'] = {
            cargo = { allFeatures = true },
            checkOnSave = {
              command = 'clippy',
            },
          },
        },
      }
    })

    setup_lsp(lspconfig.zls, {
      capabilities = capabilities,
      filetypes = { "zig" },
      settings = {
        enable_build_on_save = true,
        build_on_save_step = 'check',
      },
    })

    setup_lsp(lspconfig.gopls, {
      capabilities = capabilities,
      filetypes = { "go" },
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

    setup_lsp(lspconfig.lua_ls, {
      capabilities = capabilities,
      filetypes = { "lua" },
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

    setup_lsp(lspconfig.intelephense, {
      capabilities = capabilities,
      filetypes = { "php" }
    })

    setup_lsp(lspconfig.ts_ls, {
      capabilities = capabilities,
      filetypes = {
        'javascript',
        'typescript',
        'vue',
        'javascriptreact',
      },
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = os.getenv('HOME') .. '/.config/yarn/global/node_modules/@vue/typescript-plugin',
            languages = { 'javascript', 'typescript', 'vue' },
          },
        },
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

    setup_lsp(lspconfig.eslint, {
      capabilities = capabilities,
      filetypes = {
        'javascript',
        'typescript',
        'vue',
        'javascriptreact',
      },
    })

    setup_lsp(lspconfig.html, {
      capabilities = capabilities,
      filetypes = {
        "html",
        'templ',
      },
    })

    setup_lsp(lspconfig.svelte, {
      capabilities = capabilities,
      filetypes = { "svelte" }
    })

    setup_lsp(lspconfig.cssls, {
      capabilities = capabilities,
      filetypes = { "css", "scss", "vue" }
    })

    setup_lsp(lspconfig.tailwindcss, {
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

    setup_lsp(lspconfig.dockerls, {
      capabilities = capabilities,
      filetypes = { "docker" }
    })

    setup_lsp(lspconfig.jsonls, {
      capabilities = capabilities,
      filetypes = { "json" }
    })

    setup_lsp(lspconfig.marksman, {
      capabilities = capabilities,
      filetypes = { "markdown" }
    })

    setup_lsp(lspconfig.twiggy_language_server, {
      capabilities = capabilities,
      filetypes = { "twig" }
    })

    setup_lsp(lspconfig.nushell, {
      capabilities = capabilities,
      filetypes = { "nu" }
    })
  end
}
