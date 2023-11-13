-- TODO: make this responsive.
local function getMarginRight()
  local winWidth = vim.fn.winwidth(0)
  if winWidth <= 160 then
    return 0
  end

  return math.floor(winWidth * 0.6)
end

return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    lazy = true,
    opts = {
      window = {
        margin = { 1, 0, 1, getMarginRight() }, -- extra window margin [top, right, bottom, left]
      },
      show_help = false,
    },
    config = function(_, opts)
      local wk = require 'which-key'
      wk.setup(opts)

      -- TODO: think about keybinds here
      local Nkeymaps = {
        ['<Esc>'] = { '<cmd>:noh <cr>', 'clear highlights' },
        ['<C-j>'] = { '<cmd>:m .+1<cr>==', 'Move line down' },
        ['<C-k>'] = { '<cmd>:m .-2<cr>==', 'Move line up' },
        ['<C-s>'] = { '<C-a>', 'Increment' },
        ['<C-x>'] = { '<C-x>', 'Decrement' },
      }
      --  Remap for dealing with word wrap
      vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
      vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

      -- resize with arrow keys
      vim.keymap.set('n', '<A-Up>', ':resize -2<CR>', { silent = true })
      vim.keymap.set('n', '<A-Down>', ':resize +2<CR>', { silent = true })
      vim.keymap.set('n', '<A-Left>', ':vertical resize -2<CR>', { silent = true })
      vim.keymap.set('n', '<A-Right>', ':vertical resize +2<CR>', { silent = true })

      local Vkeymaps = {
        ['<'] = { '<gv', 'Indent left' },
        ['>'] = { '>gv', 'Inde t right' },
      }
      -- move blocks of code - TODO: make this work with wichkey.
      vim.keymap.set('v', '<C-j>', ":m '>+1<cr>gv")
      vim.keymap.set('v', '<C-k>', ":m '<-2<cr>gv")

      local NVkeymaps = {
        -- See `:help K` for why this keymap
        ['K'] = { vim.lsp.buf.hover, 'Hover Documentation' },
        ['<C-,>'] = { vim.lsp.buf.signature_help, 'Signature Documentation' },
        ['g'] = {
          name = 'goto',
          ['d'] = { vim.lsp.buf.definition, 'Goto Definition' },
          ['D'] = {
            name = 'Goto Declaration / Type Definition',
            ['d'] = { vim.lsp.buf.declaration, 'Goto Declaration' },
            ['D'] = { vim.lsp.buf.type_definition, 'Goto Type Definition' },
          },
          ['i'] = { vim.lsp.buf.implementation, 'Goto implementation' },
        },
        ['M'] = {
          name = 'surround/match', -- TAKEN in mini-surround.lua
        },
        ['<leader>b'] = {
          name = '󰘓 buffer',
        },
        ['<leader>D'] = {
          function()
            vim.cmd 'terminal LazyDocker' -- see terminal.lua
          end,
          ' LazyDocker',
        },
        ['<leader>c'] = {
          name = '󰅨 code',
          ['d'] = { vim.diagnostic.open_float, 'Open floating diagnostic message' },
          ['L'] = { vim.diagnostic.setloclist, 'Open diagnostic list' },
          ['r'] = { vim.lsp.buf.rename, 'Rename' },
          ['a'] = { vim.lsp.buf.code_action, 'Code Action' },
          ['S'] = { name = 'swap', ['a'] = { 'swap next @parameter.inner' }, ['A'] = { 'swap previous @parameter.inner' } },
          ['w'] = {
            name = 'workspace',
            ['a'] = { vim.lsp.buf.add_workspace_folder, 'Workspace add Folder' },
            ['r'] = { vim.lsp.buf.remove_workspace_folder, 'Workspace remove Folder' },
            ['l'] = {
              function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end,
              'Workspace list Folders',
            },
          },
        },
        ['<leader>d'] = {
          name = ' debug',
        },
        ['<leader>g'] = {
          name = ' git',
          ['d'] = {
            name = 'Diffview',
            ['c'] = {
              name = 'choose',
            },
            ['g'] = {
              name = 'goto',
            },
          },
        },
        ['<leader>s'] = {
          name = ' search/replace',
        },
        ['<leader>u'] = {
          name = '  Ui-Toggles',
          ['g'] = {
            name = 'git',
          },
          ['b'] = {
            name = 'buffer',
            ['N'] = { '<cmd> set nu! <CR>', 'toggle line number' },
            ['n'] = { '<cmd> set rnu! <CR>', 'toggle relative number' },
          },
          ['f'] = { '<cmd>:ToggleAutoFormat<cr>', 'toggle Autoformat on save' },
          ['l'] = { '<cmd>:ToggleAutoLint<cr>', 'toggle Autolint on save, insert leave, bufreadpost' },
          ['I'] = { '<cmd>:ToggleGuessIndent<cr>', 'toggle GuessIndent when opening a bufffer' },
          ['i'] = {
            '<cmd>:ToggleInlayHints<cr>',
            'toglge Inlayhints',
          },
          ['t'] = { '<cmd>split | terminal<cr>', 'teminal split' },
        },
        ['<leader>m'] = {
          name = ' marks',
        },
        -- Explorer:
        ['<leader>a'] = {
          name = '󰁨 AI',
          r = {
            name = 'run',
          },
        },
      }

      wk.register(Nkeymaps, { mode = { 'n' } })
      wk.register(Vkeymaps, { mode = { 'v' } })
      wk.register(NVkeymaps, { mode = { 'n', 'v' } })
    end,
  },
}
