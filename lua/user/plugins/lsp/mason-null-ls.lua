return {
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      local mason_null_ls = require("mason-null-ls")
      local null_ls = require("null-ls")

      mason_null_ls.setup({
        ensure_installed = {
          -- Opt to list sources here, when available in mason.
          "eslint_d",
          "prettierd",
          "styllua",
          "shfm"
        },
        automatic_installation = false,
        automatic_setup = true, -- Recommended, but optional
      })

      null_ls.setup({
        sources = {
          -- Add Anything not supported by mason.
        }
      })

      mason_null_ls.setup_handlers() -- If `automatic_setup` is true.
    end,
  }
}
