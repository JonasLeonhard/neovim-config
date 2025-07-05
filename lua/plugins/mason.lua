return {
  pack = {
    src = 'https://github.com/williamboman/mason.nvim',
  },
  lazy = {
    "mason.nvim",
    cmd = { 'Mason', 'MasonUpdate', 'MasonInstall', 'MasonUninstall' },
    after = function()
      require('mason').setup({
        -- !INFO: mason automatically prepends all installed binaries to the path!
        install_root_dir = vim.fn.stdpath 'data' .. '/mason',

        -- INFO: for some shells this wont append to the path correctly (eg. nushell).
        -- in these cases: please add ( := vim.fn.stdpath 'data' .. '/mason/bin' ) to your shell path.
        -- This way neovim will be able to find all installed binaries from mason
        PATH = 'prepend',
      })
    end
  }

}
