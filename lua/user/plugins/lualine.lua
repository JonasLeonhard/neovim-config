return {
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'catppuccin/nvim',
    },
    -- See `:help lualine.txt`
    opts = {
      extensions = { 'lazy' },
      options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = { 'alpha' }, -- disable in dashboard to increase startuptime
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
              local status = package.loaded['harpoon.mark'].status()
              if status == '' then
                return '[U]'
              end

              return '[' .. status .. ']'
            end,
          },
          {
            function() -- Macro recording register
              local register = vim.fn.reg_recording()
              if register ~= '' then
                return 'recording @' .. register .. ' - to stop recording press q again.'
              end
              return ''
            end,
          },
        },
        lualine_x = {
          "require('lsp-progress').progress()",
          {
            function() -- GuessIndent Toggle
              if not _GuessIndentEnabled() then
                return 'GuessIndent: off'
              end
              return ''
            end,
          },
          {
            function() -- List all registered formatters from conform
              local formatters = package.loaded['conform'].list_formatters(0)

              if not _AutoFormatEnabled() then
                return '󰉶 : --off'
              end

              if not formatters then
                return ''
              end

              if #formatters == 0 then
                return ''
              end

              local names = {}
              for _key, formatter in pairs(formatters) do
                table.insert(names, formatter.name)
              end
              return '󰉶 : [' .. table.concat(names, ',') .. ']'
            end,
            color = { gui = 'bold' },
          },
          {
            function()
              local linters = package.loaded['lint']._resolve_linter_by_ft(vim.bo.filetype)

              if not _AutoLintEnabled() then
                return '󱔲 : --off'
              end

              if not linters or #linters == 0 then
                return ''
              end

              return '󱔲 : [' .. table.concat(linters, ',') .. ']'
            end,
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

      -- hide the lualine when entering command mode,
      -- this fixes an issue, where the statusline would sometimes flicker while typing and cmp window rendering
      vim.cmd [[ autocmd CmdlineEnter * set laststatus=0 ]]
      vim.cmd [[ autocmd CmdlineLeave * set laststatus=2 ]]
      require('lualine').setup(opts)
    end,
  },
}
