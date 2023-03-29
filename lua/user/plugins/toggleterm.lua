local explorers = {
  lf = {
    dir = ".",
    selection = {}
  },
  lfRoot = {
    dir = ".",
    selection = {}
  }
}

local function setSelectionToPathsInFile(key)
  local file = "/tmp/nvim-toggleterm-selection-" .. key
  if io.open(file, "r") ~= nil then
    explorers[key].selection = {}

    for line in io.lines(file) do
      local path = vim.fn.fnameescape(line)
      table.insert(explorers[key].selection, path)
    end

    io.close(io.open(file, "r"))
    os.remove(file)
  end
end

local function setDirToPathInFile(key)
  local file = "/tmp/nvim-toggleterm-dir-" .. key
  if io.open(file, "r") ~= nil then
    for line in io.lines(file) do
      explorers[key].dir = vim.fn.fnameescape(line)
    end

    io.close(io.open(file, "r"))
    os.remove(file)
  end
end

local function getLfOpenCmd(key)
  local openPath = explorers[key].dir;
  if #(explorers[key].selection) == 1 then
    openPath = table.concat(explorers[key].selection, " ")
  end

  return "export RUN_INSIDE_NVIM=true && lf -selection-path /tmp/nvim-toggleterm-selection-" ..
      key .. " -last-dir-path /tmp/nvim-toggleterm-dir-" .. key .. " " .. openPath
end

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {
      direction = "horizontal", -- default direction
      size = vim.fn.winheight(0) / 3, -- split size
      float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = "none", -- | 'double' | 'shadow' | 'curved' | ... other options supported by win open
        -- like `size`, width and height can be a number or function which is passed the current terminal
        width = 10000,
        height = 10000,
        winblend = 3,
        zindex = 10000,
      },
    },
    config = function(_, opts)
      local toggleTerm = require("toggleterm")
      toggleTerm.setup(opts)
      local Terminal = require('toggleterm.terminal').Terminal

      -- ---------------------- Gitui -----------------------------------
      local gitui = Terminal:new({ cmd = "gitui", hidden = true, direction = "float" })
      function _Gitui_toggle()
        gitui:toggle()
      end

      -- ---------------------- LF (current buffer) ---------------------
      -- to open files in neovim:
      -- add this to your .zshrc:
      -- ```
      -- alias nvim="nvim --listen ~/.cache/nvim/server.pipe"
      -- ```
      -- then in lfrc add to open files with enter:
      -- ```
      -- map <enter> $nvim --server ~/.cache/nvim/server.pipe --remote-send "<C-w>q:edit $f<CR>"
      -- ```
      local lf = Terminal:new({
        direction = "horizontal",
        cmd = getLfOpenCmd('lf'),
        hidden = true,
        on_exit = function(terminal)
          setSelectionToPathsInFile("lf")
          setDirToPathInFile("lf")

          -- update changed parameters in terminal open cmd:
          terminal.cmd = getLfOpenCmd("lf")
        end
      })
      function _Lf_toggle()
        lf:toggle()
      end

      -- TODO: add this to lf as a gr -> go to root command?
      function _Lf_reset_to_root()
        explorers.lf.selection = {}
        explorers.lf.dir = "."
        lf.cmd = getLfOpenCmd("lf")
        print("success: reset lf to root dir.")
      end

      -- TODO: is this foolproof for all buffers?
      function _Lf_reset_to_buffer()
        local buffername = vim.fn.expand("%")
        if (buffername ~= "") then
          explorers.lf.selection = { buffername }
          lf.cmd = getLfOpenCmd("lf")
        end
      end

      vim.api.nvim_create_autocmd("BufEnter", {
        command = "lua _Lf_reset_to_buffer()",
      })

      -- ---------------------- LF (root) -----------------------------
      local lf_root = Terminal:new({
        direction = "float",
        cmd = getLfOpenCmd("lfRoot"),
        hidden = true,
        on_exit = function()
          setSelectionToPathsInFile("lfRoot")
        end
      })
      function _Lf_root_toggle()
        lf_root:toggle()
      end

      -- ------------------- Keymaps ----------------------------------
      function _Set_terminal_keymaps()
        local opts = { buffer = 0 }
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua _Set_terminal_keymaps()')
    end
  }
}
