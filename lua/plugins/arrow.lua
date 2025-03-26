return {
  'otavioschwanck/arrow.nvim',
  lazy = true,
  keys = {
    {
      'm',
      function()
        require('arrow.persist').toggle()
      end,
      mode = { 'v', 'n' },
      desc = 'Arrow toggle',
    },
    {
      '<C-l>',
      function()
        require('arrow.ui').openMenu()
      end,
      desc = 'arrow',
    },
    {
      'g1',
      function()
        require('arrow.persist').go_to(1)
      end,
      desc = 'arrow 1',
    },
    {
      'g2',
      function()
        require('arrow.persist').go_to(2)
      end,
      desc = 'arrow 2',
    },
    {
      'g3',
      function()
        require('arrow.persist').go_to(3)
      end,
      desc = 'arrow 3',
    },
    {
      'g4',
      function()
        require('arrow.persist').go_to(4)
      end,
      desc = 'arrow 4',
    },
    {
      'g5',
      function()
        require('arrow.persist').go_to(5)
      end,
      desc = 'arrow 5',
    },
  },
  opts = {
    show_icons = true,
    leader_key = '<C-l>',
    buffer_leader_key = 'm',
    mappings = {
      edit = 'e',
      delete_mode = 'd',
      clear_all_items = 'C',
      toggle = 's', -- used as save if separate_save_and_remove is true
      open_vertical = 'v',
      open_horizontal = '-',
      quit = 'q',
      remove = 'x', -- only used if separate_save_and_remove is true
      next_item = 'j',
      prev_item = 'k',
    },
  },
  config = function(_, opts)
    require('arrow').setup(opts)
    _G.plugin_arrow_loaded = true
  end,
}
