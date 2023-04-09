return {
  'SmiteshP/nvim-navic',
  dependencies = { 'neovim/nvim-lspconfig' },
  config = function()
    require('nvim-navic').setup {
      highlight = true,
      icons = {
        File = ' ',
        Module = ' ',
        Namespace = ' ',
        Package = ' ',
        Class = ' ',
        Method = ' ',
        Property = ' ',
        Field = ' ',
        Constructor = ' ',
        Enum = ' ',
        Interface = ' ',
        Function = ' ',
        Variable = ' ',
        Constant = ' ',
        String = ' ',
        Number = ' ',
        Boolean = ' ',
        Array = ' ',
        Object = ' ',
        Key = ' ',
        Null = ' ',
        EnumMember = ' ',
        Struct = ' ',
        Event = ' ',
        Operator = ' ',
        TypeParameter = ' ',
      },
    }
    -- TODO: for some reason the catppuccin integration for navic doesn work sometimes.
    local ns = 0
    local C = require 'catppuccin.palettes.mocha'
    local background = C.crust
    vim.api.nvim_set_hl(ns, 'NavicIconsFile', { fg = C.blue, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsModule', { fg = C.blue, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsNamespace', { fg = C.blue, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsPackage', { fg = C.blue, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsClass', { fg = C.yellow, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsMethod', { fg = C.blue, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsProperty', { fg = C.green, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsField', { fg = C.green, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsConstructor', { fg = C.blue, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsEnum', { fg = C.green, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsInterface', { fg = C.yellow, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsFunction', { fg = C.blue, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsVariable', { fg = C.flamingo, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsConstant', { fg = C.peach, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsString', { fg = C.green, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsNumber', { fg = C.peach, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsBoolean', { fg = C.peach, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsArray', { fg = C.peach, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsObject', { fg = C.peach, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsKey', { fg = C.pink, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsNull', { fg = C.peach, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsEnumMember', { fg = C.red, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsStruct', { fg = C.blue, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsEvent', { fg = C.blue, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsOperator', { fg = C.sky, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicIconsTypeParameter', { fg = C.blue, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicText', { fg = C.teal, bg = background })
    vim.api.nvim_set_hl(ns, 'NavicSeparator', { fg = C.text, bg = background })
  end,
}
