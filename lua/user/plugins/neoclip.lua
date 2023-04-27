return {
  'AckslD/nvim-neoclip.lua',
  event = 'VeryLazy',
  dependencies = {
    { 'kkharji/sqlite.lua', module = 'sqlite' },
    { 'nvim-telescope/telescope.nvim' },
  },
  config = function()
    require('neoclip').setup {
      enable_persistent_history = true,
    }
    require('telescope').load_extension 'neoclip'
  end,
}
