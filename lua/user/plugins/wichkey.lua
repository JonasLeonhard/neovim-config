-- TODO: make this responsive.
local function getMarginRight()
  local winWidth = vim.fn.winwidth(0);
  if winWidth <= 160 then
    return 0
  end

  return math.floor(winWidth * 0.6)
end

return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      window = {
        margin = { 1, getMarginRight(), 1, 0 }, -- extra window margin [top, right, bottom, left]
      },
      show_help = false
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)

      -- TODO: think about keybinds here
      local keymaps = {
        mode = { "n", "v" },
        -- See `:help K` for why this keymap
        ["K"] = { vim.lsp.buf.hover, "Hover Documentation" },
        ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature Documentation" },
        ["g"] = {
          name = "goto",
          ["k"] = { "<cmd>BufferLineCycleNext<cr>", "next buffer" },
          ["j"] = { "<cmd>BufferLineCyclePrev<cr>", "previous buffer" },
          ["d"] = { vim.lsp.buf.definition, "Goto Definition" },
          ["D"] = { vim.lsp.buf.declaration, "Goto Declaration" },
          ["i"] = { vim.lsp.buf.implementation, "Goto implementation" },
          ["r"] = { require('telescope.builtin').lsp_references, "Goto References" },
          ["t"] = { vim.lsp.buf.type_definition, "Goto Type Definition" },
        },
        ["M"] = {
          name = "surround/match",
          ["s"] = { name = "surround add" }
        },
        ["<leader>b"] = {
          name = "buffer",
          ["j"] = { "<cmd>BufferLineCycleNext<cr>", "next buffer" },
          ["k"] = { "<cmd>BufferLineCyclePrev<cr>", "previous buffer" },
          ["h"] = { "<cmd>BufferLineCloseLeft<cr>", "close left" },
          ["l"] = { "<cmd>BufferLineCloseRight<cr>", "close right" },
          ["s"] = { "<cmd>BufferLinePick<cr>", "pick" },
          ["c"] = { "<cmd>BufferLinePickClose<cr>", "pick close" },
          ["q"] = { function() require("mini.bufremove").delete(0, false) end, "Delete Buffer" },
          ["b"] = { require('telescope.builtin').buffers, "Find existing buffers" }
        },
        ["<leader>c"] = {
          name = "code",
          ["D"] = { vim.diagnostic.open_float, "Open floating diagnostic message" },
          ["[D"] = { vim.diagnostic.goto_prev, "go to previous diagnostic message" },
          ["]D"] = { vim.diagnostic.goto_next, "go to next diagnostic message" },
          ["l"] = { vim.diagnostic.setloclist, "Open diagnostic list" },
          ["r"] = { vim.lsp.buf.rename, "Rename" },
          ["a"] = { vim.lsp.buf.code_action, "Code Action" },
          ["s"] = { require('telescope.builtin').lsp_document_symbols, "Document Symbols" },
          ["w"] = {
            name = "workspace",
            ["s"] = { require('telescope.builtin').lsp_dynamic_workspace_symbols, "Workspace Symbols" },
            ["a"] = { vim.lsp.buf.add_workspace_folder, "Workspace add Folder" },
            ["r"] = { vim.lsp.buf.remove_workspace_folder, "Workspace remove Folder" },
            ["l"] = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "Workspace list Folders" }
          },
          ["f"] = { vim.lsp.buf.format, "Format Buffer" },
          ["t"] = { "<cmd>lua require('alternate-toggler').toggleAlternate()<CR>", "Toggle Cursor Alternate" }
        },
        ["<leader>f"] = { require('telescope.builtin').find_files, "Find files" },
        ["<leader>g"] = {
          name = "git",
          ["g"] = { "<cmd>lua _Gitui_toggle()<cr>", "Gitui" }
        },
        ["<leader>q"] = {
          name = "quit/session"
        },
        ["<leader>s"] = {
          name = "search",
          ["?"] = { require("telescope.builtin").oldfiles, "Find recently opened files" },
          ["h"] = { require("telescope.builtin").help_tags, "Help" },
          ["w"] = { require("telescope.builtin").grep_string, "Cursor Word" },
          ["g"] = { require("telescope.builtin").live_grep, "Grep" },
          ["d"] = { require("telescope.builtin").diagnostics, "Diagnostics" },
        },
        ["<leader>u"] = {
          name = "  Ui-Toggles",
          ["t"] = { "<cmd>ToggleTerm<cr>", "Terminal" }
        },
        ["<leader>x"] = {
          name = "diagnostics/quickfix"
        },
        -- Explorer:
        ["<leader>e"] = { "<cmd>lua _Lf_toggle()<cr>", "Lf (current dir)" },
        ["<leader>."] = { "<cmd>lua _Lf_reset_to_root()<cr>", "Lf reset to root" },
        ["<leader>E"] = { "<cmd>lua _Lf_root_toggle()<cr>", "Lf (root dir)" }
      }

      -- Other keybinds:
      --  Remap for dealing with word wrap
      vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
      vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

      wk.register(keymaps)
    end,
  },
}
