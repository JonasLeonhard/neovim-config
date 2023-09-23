return {
  'windwp/nvim-ts-autotag',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = 'User FileOpened',
  lazy = true,
  opts = {
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
}
