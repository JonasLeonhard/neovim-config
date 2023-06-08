return {
  'echasnovski/mini.surround',
  event = 'VeryLazy',
  lazy = true,
  opts = {
    -- Add custom surroundings to be used on top of builtin ones. For more
    -- information ith examples, see `:h MiniSurround.config`.
    custom_surroundings = nil,

    -- Duration (in ms) of highlight hen calling `MiniSurround.highlight()`
    highlight_duration = 500,

    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      add = 'Ma', -- Add surrounding in Normal and Visual modes
      delete = 'Md', -- Delete surrounding
      find = 'Mf', -- Find surrounding (to the right)
      find_left = 'MF', -- Find surrounding (to the left)
      highlight = 'Mh', -- Highlight surrounding
      replace = 'Mr', -- Replace surrounding
      update_n_lines = 'Mn', -- Update `n_lines`

      suffix_last = 'l', -- Suffix to search ith "prev" method
      suffix_next = 'n', -- Suffix to search ith "next" method
    },

    -- Number of lines within which surrounding is searched
    n_lines = 20,

    -- Whether to respect selection type:
    -- - Place surroundings on separate lines in linewise mode.
    -- - Place surroundings on each line in blockwise mode.
    respect_selection_type = false,

    -- How to search for surrounding (first inside current line, then inside
    -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
    -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
    -- see `:h MiniSurround.config`.
    search_method = 'cover',

    -- Whether to disable showing non-error feedback
    silent = false,
  },
  config = function(_, opts)
    -- use gz mappings instead of s to prevent conflict with leap
    require('mini.surround').setup(opts)
  end,
}
