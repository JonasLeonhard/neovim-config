return {
  -- each server_name key in this tabe will be called as
  -- require('lspconfig')[<server_name>].setup({ capabilities, onAttach, ...rest })
  rust_analyzer = {
    -- ...rest here:
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    }
  },
  eslint = {},
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    }
  },
}
