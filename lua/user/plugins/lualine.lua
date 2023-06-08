local function list_registered_null_ls_providers_names(filetype)
  local s = require 'null-ls.sources'
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    table.insert(registered, source.name)
  end
  return vim.fn.uniq(registered)
end

return {
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'catppuccin/nvim' },
    event = 'VeryLazy',
    lazy = true,
    -- See `:help lualine.txt`
    opts = {
      extensions = { 'lazy' },
      options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = {
          'branch',
        },
        lualine_c = {
          'filename',
          'diagnostics',
          {
            function() -- Harpoon
              local status = require('harpoon.mark').status()
              if status == '' then
                return '[U]'
              end

              return '[' .. status .. ']'
            end,
          },
          'navic',
        },
        lualine_x = {
          {
            function() -- Autoformatting Toggle
              if not _GuessIndentEnabled() then
                return 'GuessIndent: off'
              end
              return ''
            end,
          },
          {
            function() -- Autoformatting Toggle
              if not _AutoFormatEnabled() then
                return 'AutoFormat: off'
              end
              return ''
            end,
          },
          {
            function() -- List all registered language servers and null-ls linters/formatters
              local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
              local buf_client_names = {}

              if next(buf_clients) == nil then
                return '󰴀 '
              end

              -- add all clients but null-ls
              for _, client in pairs(buf_clients) do
                if client.name ~= 'null-ls' then
                  table.insert(buf_client_names, client.name)
                end
              end

              -- add null-ls providers seperatly
              local supported_formatters = list_registered_null_ls_providers_names(vim.bo.filetype)
              vim.list_extend(buf_client_names, supported_formatters)

              return '󱙋 [' .. table.concat(buf_client_names, ', ') .. ']'
            end,
            color = { gui = 'bold' },
          },
        },
        lualine_y = {
          'filetype',
        },
        lualine_z = { 'location' },
      },
    },
    config = function(_, opts)
      local Colors = require('catppuccin.palettes').get_palette()
      local options = require('catppuccin').options

      local transparent_bg = options.transparent_background and 'NONE' or Colors.mantle
      local theme = {
        normal = {
          a = { bg = Colors.blue, fg = Colors.mantle, gui = 'bold' },
          b = { bg = transparent_bg, fg = Colors.blue }, -- changed
          c = { bg = transparent_bg, fg = Colors.surface2 },
        },
        insert = {
          a = { bg = Colors.green, fg = Colors.base, gui = 'bold' },
          b = { bg = transparent_bg, fg = Colors.teal },
        },
        terminal = {
          a = { bg = Colors.green, fg = Colors.base, gui = 'bold' },
          b = { bg = transparent_bg, fg = Colors.teal },
        },
        command = {
          a = { bg = Colors.peach, fg = Colors.base, gui = 'bold' },
          b = { bg = transparent_bg, fg = Colors.peach },
        },
        visual = {
          a = { bg = Colors.mauve, fg = Colors.base, gui = 'bold' },
          b = { bg = transparent_bg, fg = Colors.mauve },
        },
        replace = {
          a = { bg = Colors.red, fg = Colors.base, gui = 'bold' },
          b = { bg = transparent_bg, fg = Colors.red },
        },
        inactive = {
          a = { bg = transparent_bg, fg = Colors.blue },
          b = { bg = transparent_bg, fg = Colors.surface1, gui = 'bold' },
          c = { bg = transparent_bg, fg = Colors.overlay0 },
        },
      }
      opts.options.theme = theme
      require('lualine').setup(opts)
    end,
  },
}
