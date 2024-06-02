return {
  'echasnovski/mini.ai',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects'
  },
  lazy = true,
  event = "VeryLazy",
  opts = function()
    local ai = require('mini.ai')
    return {
      mappings = {
        -- Main textobject prefixes
        around = 'a',
        inside = 'i',

        -- Next/last textobjects
        around_next = 'aN',
        inside_next = 'iN',
        around_last = 'aL',
        inside_last = 'iL',

        -- Move cursor to corresponding edge of `a` textobject
        goto_left = 'g[',
        goto_right = 'g]',
      },
      n_lines = 500,
      -- Function definition (needs treesitter queries with these captures from nvim-treesitter-textobjects)
      F = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }),
      o = ai.gen_spec.treesitter({
        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
      }),
      l = ai.gen_spec.treesitter({ a = "@loop.outer", i = "@loop.inner" }),
      c = ai.gen_spec.treesitter({ a = "@conditional.outer", i = "@conditional.inner" }),
      O = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
      A = ai.gen_spec.treesitter({ a = "@assignment.outer", i = "@assignment.outer" }),
      k = ai.gen_spec.treesitter({ a = "@assignment.lhs", i = "@assignment.lhs" }),
      v = ai.gen_spec.treesitter({ a = "@assignment.rhs", i = "@assignment.rhs" }),
      C = ai.gen_spec.treesitter({ a = "@comment.outer", i = "@comment.inner" }),
      n = ai.gen_spec.treesitter({ a = "@number.inner", i = "@number.outer" }),
      r = ai.gen_spec.treesitter({ a = "@return.outer", i = "@return.inner" }),
      s = ai.gen_spec.treesitter({ a = "@statement.outer", i = "@statement.inner" }),
      S = ai.gen_spec.treesitter({ a = "@scopename.outer", i = "@scopename.inner" }),
    }
  end
}
