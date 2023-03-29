return {
  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    event = "VeryLazy",
    after = { "JoosepAlviste/nvim-ts-context-commentstring" },
    config = function()
      require("Comment").setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    event = "VeryLazy"
  }
}
