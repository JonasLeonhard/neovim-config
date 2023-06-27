return {
  'phaazon/hop.nvim',
  lazy = true,
  branch = 'v2',
  keys = {
    {
      'f',
      function()
        require('hop').hint_char1 {
          direction = require('hop.hint').HintDirection.AFTER_CURSOR,
          current_line_only = true,
        }
      end,
      desc = 'Find <char> in current line AFTER_CURSOR(hop)',
      mode = 'n',
    },
    {
      'F',
      function()
        require('hop').hint_char1 {
          direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
          current_line_only = true,
        }
      end,
      desc = 'Find <char> in current line BEFORE_CURSOR(hop)',
      mode = 'n',
    },
    {
      't',
      function()
        require('hop').hint_char1 {
          direction = require('hop.hint').HintDirection.AFTER_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        }
      end,
      desc = 'To <char> AFTER_CURSOR(hop)',
      mode = 'n'
    },
    {
      'T',
      function()
        require('hop').hint_char1 {
          direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
          current_line_only = true,
          hint_offset = -1,
        }
      end,
      desc = 'To <char> BEFORE_CURSOR(hop)',
      mode = 'n'
    },
  },
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
  end,
}
