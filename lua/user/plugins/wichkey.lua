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
    opts = {
      window = {
        margin = { 1, getMarginRight(), 1, 0 }, -- extra window margin [top, right, bottom, left]
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
      }
      --  Remap for dealing with word wrap
      vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
      vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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
        ['f'] = {
          function()
            require('hop').hint_char1 {
              direction = require('hop.hint').HintDirection.AFTER_CURSOR,
              current_line_only = true,
            }
          end,
          'Find <char> in current line AFTER_CURSOR(hop)',
        },
        ['F'] = {
          function()
            require('hop').hint_char1 {
              direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
              current_line_only = true,
            }
          end,
          'Find <char> in current line BEFORE_CURSOR(hop)',
        },
        ['t'] = {
          function()
            require('hop').hint_char1 {
              direction = require('hop.hint').HintDirection.AFTER_CURSOR,
              current_line_only = true,
              hint_offset = -1,
            }
          end,
          'To <char> AFTER_CURSOR(hop)',
        },
        ['T'] = {
          function()
            require('hop').hint_char1 {
              direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
              current_line_only = true,
              hint_offset = -1,
            }
          end,
          'To <char> BEFORE_CURSOR(hop)',
        },
        ['g'] = {
          name = 'goto',
          ['k'] = { '<cmd>BufferLineCycleNext<cr>', 'next buffer' },
          ['j'] = { '<cmd>BufferLineCyclePrev<cr>', 'previous buffer' },
          ['d'] = { vim.lsp.buf.definition, 'Goto Definition' },
          ['D'] = {
            name = 'Goto Declaration / Type Definition',
            ['d'] = { vim.lsp.buf.declaration, 'Goto Declaration' },
            ['D'] = { vim.lsp.buf.type_definition, 'Goto Type Definition' },
          },
          ['i'] = { vim.lsp.buf.implementation, 'Goto implementation' },
          ['r'] = { require('telescope.builtin').lsp_references, 'Goto References' },
          ['f'] = {
            function()
              require('hop').hint_char1 {
                direction = require('hop.hint').HintDirection.AFTER_CURSOR,
                current_line_only = false,
              }
            end,
            'Find <char> globally AFTER_CURSOR(hop)',
          },
          ['F'] = {
            function()
              require('hop').hint_char1 {
                direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
                current_line_only = false,
              }
            end,
            'Find <char> globally BEFORE_CURSOR(hop)',
          },
          ['t'] = {
            function()
              require('hop').hint_char1 {
                direction = require('hop.hint').HintDirection.AFTER_CURSOR,
                current_line_only = false,
                hint_offset = -1,
              }
            end,
            'To <char> AFTER_CURSOR(hop)',
          },
          ['T'] = {
            function()
              require('hop').hint_char1 {
                direction = require('hop.hint').HintDirection.BEFORE_CURSOR,
                current_line_only = false,
                hint_offset = -1,
              }
            end,
            'To <char> BEFORE_CURSOR(hop)',
          },
        },
        ['M'] = {
          name = 'surround/match', -- TAKEN in mini-surround.lua
        },
        ['<leader>b'] = {
          name = 'buffer',
          ['j'] = { '<cmd>BufferLineCycleNext<cr>', 'next buffer' },
          ['k'] = { '<cmd>BufferLineCyclePrev<cr>', 'previous buffer' },
          ['h'] = { '<cmd>BufferLineCloseLeft<cr>', 'close left' },
          ['l'] = { '<cmd>BufferLineCloseRight<cr>', 'close right' },
          ['s'] = { '<cmd>BufferLinePick<cr>', 'pick' },
          ['c'] = { '<cmd>BufferLinePickClose<cr>', 'pick close' },
          ['q'] = {
            function()
              require('mini.bufremove').delete(0, false)
            end,
            'Delete Buffer',
          },
          ['b'] = { require('telescope.builtin').buffers, 'Find existing buffers' },
        },
        ['<leader>c'] = {
          name = 'code',
          ['d'] = { vim.diagnostic.open_float, 'Open floating diagnostic message' },
          ['[d'] = { vim.diagnostic.goto_prev, 'go to previous diagnostic message' },
          [']d'] = { vim.diagnostic.goto_next, 'go to next diagnostic message' },
          ['l'] = { vim.diagnostic.setloclist, 'Open diagnostic list' },
          ['r'] = { vim.lsp.buf.rename, 'Rename' },
          ['a'] = { vim.lsp.buf.code_action, 'Code Action' },
          ['s'] = { require('telescope.builtin').lsp_document_symbols, 'Document Symbols' },
          ['w'] = {
            name = 'workspace',
            ['s'] = { require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols' },
            ['a'] = { vim.lsp.buf.add_workspace_folder, 'Workspace add Folder' },
            ['r'] = { vim.lsp.buf.remove_workspace_folder, 'Workspace remove Folder' },
            ['l'] = {
              function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end,
              'Workspace list Folders',
            },
          },
          ['f'] = { vim.lsp.buf.format, 'Format Buffer' },
          ['t'] = { "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>", 'Toggle Cursor Alternate' },
        },
        ['<leader>f'] = { require('telescope.builtin').find_files, 'Find files' },
        ['<leader>g'] = {
          name = 'git',
          ['g'] = { '<cmd>lua _Gitui_toggle()<cr>', 'Gitui' },
          [']'] = {
            function()
              if vim.wo.diff then
                return ']c'
              end
              vim.schedule(function()
                require('gitsigns').next_hunk()
              end)
              return '<Ignore>'
            end,
            'Jump to next hunk',
            opts = { expr = true },
          },
          ['['] = {
            function()
              if vim.wo.diff then
                return '[c'
              end
              vim.schedule(function()
                require('gitsigns').prev_hunk()
              end)
              return '<Ignore>'
            end,
            'Jump to prev hunk',
            opts = { expr = true },
          },
          ['r'] = {
            function()
              require('gitsigns').reset_hunk()
            end,
            'Reset hunk',
          },
          ['h'] = {
            function()
              require('gitsigns').preview_hunk()
            end,
            'Preview hunk',
          },
          ['b'] = {
            function()
              package.loaded.gitsigns.blame_line()
            end,
            'Blame line',
          },
        },
        ['<leader>q'] = {
          name = 'quit/session',
        },
        ['<leader>s'] = {
          name = 'search',
          ['?'] = { require('telescope.builtin').oldfiles, 'Find recently opened files' },
          ['h'] = { require('telescope.builtin').help_tags, 'Help' },
          ['w'] = { require('telescope.builtin').grep_string, 'Cursor Word' },
          ['g'] = { require('telescope.builtin').live_grep, 'Grep' },
          ['d'] = { require('telescope.builtin').diagnostics, 'Diagnostics' },
        },
        ['<leader>u'] = {
          name = '  Ui-Toggles',
          ['t'] = { '<cmd>ToggleTerm<cr>', 'Terminal' },
          ['g'] = {
            name = 'git',
            ['d'] = {
              function()
                require('gitsigns').toggle_deleted()
              end,
              'GitSigns Toggle deleted',
            },
          },
          ['b'] = {
            name = 'buffer',
            ['N'] = { '<cmd> set nu! <CR>', 'toggle line number' },
            ['n'] = { '<cmd> set rnu! <CR>', 'toggle relative number' },
          },
          ['f'] = { '<cmd>:ToggleAutoFormat<cr>', 'toggle Autoformat on save' },
          ['M'] = { '<cmd>MarksToggleSigns<cr>' },
        },
        ['<leader>x'] = {
          name = 'diagnostics/quickfix',
        },
        ['<leader>m'] = {
          name = 'marks & harpoon',
          ['l'] = { '<cmd>Telescope harpoon marks<cr>', 'list Marks' },
          ['m'] = { "<cmd>:lua require('harpoon.ui').toggle_quick_menu()<cr>", 'Marks (builtin)' },
          ['a'] = { "<cmd>:lua require('harpoon.mark').add_file()<cr>", 'Add File Mark' },
          ['d'] = { "<cmd>:lua require('harpoon.mark').toggle_file()<cr>", 'Toggle File Mark' },
          ['n'] = { "<cmd>:lua require('harpoon.ui').nav_next() <cr>", 'Next Mark' },
          ['b'] = { "<cmd>:lua require('harpoon.ui').nav_prev()<cr>", 'Prev Mark' },
          ['1'] = { "<cmd>:lua require('harpoon.ui').nav_file(1)<cr>", 'Navigate to Harpoon Mark (1)' },
          ['2'] = { "<cmd>:lua require('harpoon.ui').nav_file(2)<cr>", 'Navigate to Harpoon Mark (2)' },
          ['3'] = { "<cmd>:lua require('harpoon.ui').nav_file(3)<cr>", 'Navigate to Harpoon Mark (3)' },
          ['4'] = { "<cmd>:lua require('harpoon.ui').nav_file(4)<cr>", 'Navigate to Harpoon Mark (4)' },
          ['5'] = { "<cmd>:lua require('harpoon.ui').nav_file(5)<cr>", 'Navigate to Harpoon Mark (5)' },
          ['M'] = {
            name = 'Marks',
            ['a'] = { '<cmd>MarksListAll<cr>', 'List All' },
            ['b'] = { '<cmd>MarksListBuf<cr>', 'List Buffer' },
            ['g'] = { '<cmd>MarksListGlobal<cr>', 'List Global' },
            ['h'] = {
              "<cmd>:lua print('[mx] = set Mark <x>') print('[m,] = Set the next alphabetical lowercase mark') print('[dmx] = delete mark <x>') print('[dm-] = delete all marks on the current line') print('[dm<space>] = delete all marks in buffer') print('[m]] = move to next mark') print('[m[] = move to prev mark') print('[m:] = preview mark') print('[m0-9] = bookmark from bookmarkgroup') print('[dm0-9] = delete bookmark from bookmarkgroup') print('[m{] = move to next bookmark') print('[m}] = move to prev bookmark') print('[dm=] = delete bookmark under cursor')<cr>",
              'Keybind help',
            },
            ['d'] = { '<cmd>:delmarks a-zA-Z0-9<cr>', 'Delete all marks globally' },
          },
        },
        -- Explorer:
        ['<leader>e'] = { '<cmd>lua _Lf_toggle()<cr>', 'Lf (current dir)' },
        ['<leader>.'] = { '<cmd>lua _Lf_reset_to_root()<cr>', 'Lf reset to root' },
        ['<leader>E'] = { '<cmd>lua _Lf_root_toggle()<cr>', 'Lf (root dir)' },
      }

      wk.register(Nkeymaps, { mode = { 'n' } })
      wk.register(Vkeymaps, { mode = { 'v' } })
      wk.register(NVkeymaps, { mode = { 'n', 'v' } })
    end,
  },
}
