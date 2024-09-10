return {
  'echasnovski/mini.hipatterns',
  version = '*',
  lazy = true,
  event = 'VeryLazy',
  opts = function()
    local hipatterns = require 'mini.hipatterns'
    return {
      highlighters = {
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        info = { pattern = '%f[%w]()INFO()%f[%W]', group = 'MiniHipatternsNote' },
        speed = { pattern = '%f[%w]()SPEED()%f[%W]', group = 'MiniHipatternsHack' },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
  end,
}
