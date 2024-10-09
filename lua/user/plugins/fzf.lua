return {
  "ibhagwan/fzf-lua",
  lazy = true,
  cmd = { "FzfLua" },
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      '<leader>bb',
      "<cmd>FzfLua buffers<cr>",
      desc = 'Find existing buffers',
    },
    {
      '<leader>cs',
      "<cmd>FzfLua lsp_document_symbols<cr>",
      desc = 'Document Symbols',
    },
    {
      'gr',
      "<cmd>FzfLua lsp_references<cr>",
      desc = 'Goto References',
    },
    {
      '<leader>cws',
      "<cmd>FzfLua lsp_workspace_symbols<cr>",
      desc = 'Workspace Symbols',
    },
    {
      '<leader>f',
      '<cmd>FzfLua git_files<cr>',
      desc = 'Find files (git)',
    },
    {
      '<leader>s?',
      '<cmd>FzfLua<cr>',
      desc = 'Select a Picker',
    },
    {
      '<leader>sr',
      "<cmd>FzfLua oldfiles<cr>",
      desc = 'oldfiles',
    },
    {
      '<leader>sR',
      "<cmd>FzfLua resume<cr>",
      desc = 'Resume last picker',
    },
    {
      '<leader>sh',
      "<cmd>FzfLua helptags<cr>",
      desc = 'Help',
    },
    {
      '<leader>sv',
      "<cmd>FzfLua grep_isual<cr>",
      desc = 'Grep Word',
    },
    {
      '<leader>sw',
      "<cmd>FzfLua grep_cWORD<cr>",
      desc = 'Grep Word',
    },
    {
      '<leader>sg',
      "<cmd>FzfLua live_grep_native<cr>",
      desc = 'Grep',
    },
    {
      '<leader>sd',
      "<cmd>FzfLua diagnostics_document<cr>",
      desc = 'Diagnostics (document)',
    },
    {
      '<leader>sD',
      "<cmd>FzfLua diagnostics_workspace<cr>",
      desc = 'Diagnostics (workspace)',
    },
    {
      '<leader>sf',
      '<cmd>FzfLua files<cr>',
      desc = 'Find files (all)',
    },
    {
      '<leader>sm',
      '<cmd>FzfLua marks<cr>',
      desc = 'Find Marks',
    },
    {
      '<leader>bl',
      "<cmd>FzfLua buffers<cr>",
      desc = 'Buffers',
    },
    {
      '<leader>bj',
      '<cmd>bnext<cr>',
      desc = 'buffer next',
    },
    {
      '<leader>bk',
      '<cmd>bprevious<cr>',
      desc = 'buffer prev',
    },
  },
  config = function()
    local actions = require "fzf-lua.actions"
    local opts = {
      winopts = {
        height  = 0.4, -- window height
        width   = 1,
        row     = 1,   -- window row position (0=top, 1=bottom)
        col     = 0,
        border  = 'none',
        preview = {
          title      = false,
          horizontal = 'right:45%', -- right|left:size
        },
      },
      keymap = {
        builtin = {
          false,                 -- do not inherit from defaults
          ["?"]        = "toggle-help",
          ["<M-Esc>"]  = "hide", -- hide fzf-lua, `:FzfLua resume` to continue
          ["<F1>"]     = "toggle-help",
          ["<F2>"]     = "toggle-fullscreen",
          -- Only valid with the 'builtin' previewer
          ["<F3>"]     = "toggle-preview-wrap",
          ["<F4>"]     = "toggle-preview",
          -- Rotate preview clockwise/counter-clockwise
          ["<F5>"]     = "toggle-preview-ccw",
          ["<F6>"]     = "toggle-preview-cw",
          ["<down>"]   = "preview-page-down",
          ["<up>"]     = "preview-page-up",
          ["<S-down>"] = "preview-down",
          ["<S-up>"]   = "preview-up",
        },
        fzf = {
          false, -- do not inherit from defaults
          -- fzf '--bind=' options
          ["ctrl-d"]     = "half-page-down",
          ["ctrl-u"]     = "half-page-up",
          -- fzf '--bind=' options
          ["ctrl-z"]     = "abort",
          ["ctrl-b"]     = "unix-line-discard",
          ["ctrl-a"]     = "beginning-of-line",
          ["ctrl-e"]     = "end-of-line",
          ["ctrl-y"]     = "toggle-all",
          ["alt-g"]      = "last",
          ["alt-G"]      = "first",
          -- Only valid with fzf previewers (bat/cat/git/etc)
          ["f3"]         = "toggle-preview-wrap",
          ["f4"]         = "toggle-preview",
          ["shift-down"] = "preview-page-down",
          ["shift-up"]   = "preview-page-up",
        },
      },
      actions = {
        files = {
          false,
          ["enter"]  = actions.file_edit_or_qf,
          ["ctrl-s"] = actions.file_split,
          ["ctrl-v"] = actions.file_vsplit,
          ["ctrl-t"] = actions.file_tabedit,
          ["ctrl-q"] = actions.file_sel_to_qf,
          ["ctrl-l"] = actions.file_sel_to_ll,
        },
      },
      fzf_opts = {
        ["--layout"] = "default",
        ["--color"] =
        "spinner:#f5e0dc,hl:#89b4fa,fg:#cdd6f4,header:#89b4fa,info:#cba6f7,pointer:#f5e0dc,marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#89b4fa,selected-bg:#45475a",
      },
      grep = {
        rg_opts =
        "--column --line-number --no-heading --color=always --colors 'match:fg:blue' --colors 'path:fg:white' --colors 'column:fg:white' --colors 'line:fg:white' --smart-case --max-columns=4096 -e",
      }
    }

    require('fzf-lua').setup(opts)
  end
}
