return {
  -- each server_name key in this tabe will be called as
  -- require('lspconfig')[<server_name>].setup({ capabilities, onAttach, ...rest })
  rust_analyzer = {
    -- ...rest here:
    settings = {
      ['rust-analyzer'] = {
        cargo = { allFeatures = true },
        checkOnSave = {
          command = 'clippy',
        },
      },
    },
  },
  eslint = {},
  gopls = {
    hints = {
      assignVariableTypes = true,
      compositeLiteralFields = true,
      compositeLiteralTypes = true,
      constantValues = true,
      functionTypeParameters = true,
      parameterNames = true,
      rangeVariableTypes = true,
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        hint = { enable = true },
      },
    },
  },
  tsserver = {
    -- yarn global add @vue/typescript-plugin
    init_options = {
      plugins = {
        {
          name = '@vue/typescript-plugin',
          location = os.getenv 'HOME' .. '/.config/yarn/global/node_modules/@vue/typescript-plugin',
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
          includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
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
          includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
  },
  tailwindcss = {
    filetypes = {
      'templ',
      'aspnetcorerazor',
      'astro',
      'astro-markdown',
      'blade',
      'django-html',
      'edge',
      'eelixir',
      'ejs',
      'erb',
      'eruby',
      'gohtml',
      'haml',
      'handlebars',
      'hbs',
      'html',
      'html-eex',
      'jade',
      'leaf',
      'liquid',
      'markdown',
      'mdx',
      'mustache',
      'njk',
      'nunjucks',
      'php',
      'razor',
      'slim',
      'twig',
      'css',
      'less',
      'postcss',
      'sass',
      'scss',
      'stylus',
      'sugarss',
      'javascript',
      'javascriptreact',
      'reason',
      'rescript',
      'typescript',
      'typescriptreact',
      'vue',
      'svelte',
      -- include any other filetypes where you need tailwindcss
    },
    init_options = {
      userLanguages = {
        templ = 'html',
      },
    },
  },
  html = {
    filetypes = {
      'templ',
    },
  },
  zls = {
    -- https://kristoff.it/blog/improving-your-zls-experience/
    settings = {
      enable_build_on_save = true,
      build_on_save_step = 'check',
    },
  },
}
