return {
  "folke/snacks.nvim",
  lazy = true,
  event = "VeryLazy",
  opts = {
    picker = {
      prompt = "",
      ui_select = true,
      auto_close = false,
      layout = { preset = "ivy" },
      layouts = {
        ivy = {
          reverse = true,
          layout = {
            box = "vertical",
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.4,
            border = "none",
            title = " {title} {live} {flags}",
            title_pos = "left",
            {
              box = "horizontal",
              { win = "list",    border = "none" },
              { win = "preview", title = "{preview}", width = 0.4, border = "none" },
            },
            { win = "input", height = 1, border = "none" },
          },
        }
      },
      sources = {
        select = {
          layout = { preset = "ivy" }, -- This ensures ui_select uses your ivy layout
        }
      },
      win = {
        -- input window
        input = {
          keys = {
            ["∂"] = { "inspect", mode = { "n", "i" }, desc = false, }, -- alt-d
            ["ƒ"] = { "toggle_follow", mode = { "i", "n" }, desc = false }, -- alt-f
            ["ª"] = { "toggle_hidden", mode = { "i", "n" }, desc = false }, --alt-h
            ["⁄"] = { "toggle_ignored", mode = { "i", "n" }, desc = false }, --alt-i
            ["µ"] = { "toggle_maximize", mode = { "i", "n" }, desc = false }, --alt-m
            ["π"] = { "toggle_preview", mode = { "i", "n" }, desc = false }, --alt-p
            ["<C-TAB>"] = { "select_all", mode = { "n", "i" }, desc = false },
            ["∑"] = { "cycle_win", mode = { "n", "i" }, desc = false }, --alt-w
          },
        },
        list = {
          keys = {
            ["∂"] = { "inspect", mode = { "n", "i" }, desc = false }, -- alt-d
            ["ƒ"] = { "toggle_follow", mode = { "i", "n" }, desc = false }, -- alt-f
            ["ª"] = { "toggle_hidden", mode = { "i", "n" }, desc = false }, --alt-h
            ["⁄"] = { "toggle_ignored", mode = { "i", "n" }, desc = false }, --alt-i
            ["µ"] = { "toggle_maximize", mode = { "i", "n" }, desc = false }, --alt-m
            ["π"] = { "toggle_preview", mode = { "i", "n" }, desc = false }, --alt-p
            ["<C-TAB>"] = { "select_all", mode = { "n", "i" }, desc = false },
            ["∑"] = { "cycle_win", mode = { "n", "i" }, desc = false }, --alt-w
          },
        },
      },
    },
  },
  keys = {
    -- Top Pickers
    { "<leader>f",      function() Snacks.picker.smart() end,                 desc = "Smart Find Files" },
    { "<leader>sb",     function() Snacks.picker.buffers() end,               desc = "Buffers" },
    { "<leader>sP",     function() Snacks.picker.pickers() end,               desc = "Pickers" },
    -- find
    { "<leader>sf",     function() Snacks.picker.files() end,                 desc = "Find Files" },
    { "<leader>sG",     function() Snacks.picker.git_files() end,             desc = "Find Git Files" },
    { "<leader>sr",     function() Snacks.picker.recent() end,                desc = "Recent" },
    -- Grep
    { "<leader>sl",     function() Snacks.picker.lines() end,                 desc = "Buffer Lines" },
    { "<leader>sB",     function() Snacks.picker.grep_buffers() end,          desc = "Grep Open Buffers" },
    { "<leader>sg",     function() Snacks.picker.grep() end,                  desc = "Grep" },
    -- search
    { "<leader>sD",     function() Snacks.picker.diagnostics() end,           desc = "Diagnostics" },
    { "<leader>s<C-d>", function() Snacks.picker.diagnostics_buffer() end,    desc = "Buffer Diagnostics" },
    { "<leader>sj",     function() Snacks.picker.jumps() end,                 desc = "Jumps" },
    { "<leader>sL",     function() Snacks.picker.loclist() end,               desc = "Location List" },
    { "<leader>sm",     function() Snacks.picker.marks() end,                 desc = "Marks" },
    { "<leader>sq",     function() Snacks.picker.qflist() end,                desc = "Quickfix List" },
    { "<leader>sR",     function() Snacks.picker.resume() end,                desc = "Resume" },
    { "<leader>su",     function() Snacks.picker.undo() end,                  desc = "Undo History" },
    -- LSP
    { "gd",             function() Snacks.picker.lsp_definitions() end,       desc = "Goto Definition" },
    { "gD",             function() Snacks.picker.lsp_declarations() end,      desc = "Goto Declaration" },
    { "gr",             function() Snacks.picker.lsp_references() end,        nowait = true,                  desc = "References" },
    { "gI",             function() Snacks.picker.lsp_implementations() end,   desc = "Goto Implementation" },
    { "gy",             function() Snacks.picker.lsp_type_definitions() end,  desc = "Goto T[y]pe Definition" },
    { "<leader>ss",     function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
    { "<leader>sS",     function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- buf handling
    {
      '<leader>bq',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },
    {
      '<leader>bQ',
      function()
        Snacks.bufdelete({ force = true })
      end,
      desc = 'Delete Buffer (force)',
    },
  },
}
