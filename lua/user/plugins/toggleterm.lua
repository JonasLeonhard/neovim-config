local function openPathsInFile(file)
  if io.open(file, "r") ~= nil then
    for line in io.lines(file) do
      local path = vim.fn.fnameescape(line)
      vim.cmd("edit " .. path)
    end

    io.close(io.open(file, "r"))
    os.remove(file)
  end
end

local lf_dir = '.'

return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      direction = "horizontal", -- default direction
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

      -- Custom Terminals:
      local Terminal = require('toggleterm.terminal').Terminal

      local gitui = Terminal:new({ cmd = "gitui", hidden = true, direction = "float" })
      function _Gitui_toggle()
        gitui:toggle()
      end

      -- todo: write output to tmp file, then on close, read the tmp file and https://github.com/is0n/fm-nvim/blob/master/lua/fm-nvim.lua#L119
      local lf = Terminal:new({
        cmd = "lf -selection-path /tmp/nvim-toggleterm " .. lf_dir,
        hidden = true,
        direction = "float",
        on_close = function()
          openPathsInFile('/tmp/nvim-toggleterm')
        end
      })
      function _Lf_toggle()
        lf:toggle()
      end
    end
  }
}
