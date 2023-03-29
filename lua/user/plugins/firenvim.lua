return {
  {
    'glacambre/firenvim',

    event = "VeryLazy",
    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    -- cond = not not vim.g.started_by_firenvim,
    build = function()
      require("lazy").load({ plugins = "firenvim", wait = true })
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      if not not vim.g.started_by_firenvim then
        -- hide all but text?
        vim.opt.number = false
        vim.opt.relativenumber = false;
        vim.opt.ruler = false;
        vim.opt.cmdheight = 0;
      end

      vim.g.firenvim_config = {
        globalSettings = { alt = "all" },
        localSettings = {
          [".*"] = {
            cmdline  = "neovim",
            content  = "text",
            priority = 0,
            selector = "textarea,input",
            takeover = "never"
          }
        }
      }
    end
  }
}
