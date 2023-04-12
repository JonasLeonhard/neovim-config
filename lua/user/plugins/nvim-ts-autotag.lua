return {
  'windwp/nvim-ts-autotag',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('nvim-ts-autotag').setup {
      filetypes = {
        'html',
        'twig',
        'javascript',
        'typescript',
        'javascriptreact',
        'typescriptreact',
        'svelte',
        'vue',
        'tsx',
        'twig',
        'jsx',
        'rescript',
        'xml',
        'php',
        'markdown',
        'glimmer',
        'handlebars',
        'hbs',
      },
    }
  end,
}
