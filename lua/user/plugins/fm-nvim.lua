return {
  'JonasLeonhard/fm-nvim',
  lazy = true,
  keys = {
    {
      '<leader>e',
      function()
        local path = vim.fn.expand '%:p:h'
        if path == '' then
          vim.api.nvim_command 'Broot'
        else
          -- xplr cant open paths with '{' and ']' in them withouth them beeing wrapped in qoutes ''. An example would be:
          -- xplr .../frontend/src/routes/{lang]/+layout.svelte
          -- this will cause zsh to return: 'zsh: no matches found: .../frontend/src/routes/{lang]/+layout.svelte'
          -- the following will wrap the path in quotes, to zsh does not try to pattern-match paths.
          vim.api.nvim_command('Broot' .. "'" .. path .. "'")
        end
      end,
      desc = ' Broot (current file)',
    },
    {
      '<leader>E',
      '<cmd>Broot<cr>',
      desc = ' Broot (root)',
    },
  },
  opts = {
    -- (Vim) Command used to open files
    edit_cmd = 'edit',
    -- See `Q&A` for more info
    on_close = {},
    on_open = {},
    -- UI Options
    ui = {
      -- Default UI (can be "split" or "float")
      default = 'float',
      float = {
        -- Floating window border (see ':h nvim_open_win')
        border = 'none',
        -- Highlight group for floating window/border (see ':h winhl')
        float_hl = 'TelescopeNormal',
        border_hl = 'FloatBorder',
        -- Floating Window Transparency (see ':h winblend')
        blend = 0,
        -- Num from 0 - 1 for measurements
        height = 0.7,
        width = 1,
        -- X and Y Axis of Window
        x = 0.5,
        y = 1,
      },
      split = {
        -- Direction of split
        direction = 'topleft',
        -- Size of split
        size = 24,
      },
    },
    -- Terminal commands used w/ file manager (have to be in your $PATH)
    cmds = {
      lf_cmd = 'lf', -- eg: lf_cmd = "lf -command 'set hidden'"
      fm_cmd = 'fm',
      nnn_cmd = 'nnn',
      fff_cmd = 'fff',
      twf_cmd = 'twf',
      fzf_cmd = 'fzf', -- eg: fzf_cmd = "fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
      fzy_cmd = 'find . | fzy',
      xplr_cmd = 'xplr',
      vifm_cmd = 'vifm',
      skim_cmd = 'sk',
      broot_cmd = function()
        return 'broot -c ":preview_text;:select ' .. vim.fn.expand '%:p' .. '"'
      end,
      gitui_cmd = 'gitui',
      ranger_cmd = 'ranger',
      joshuto_cmd = 'joshuto',
      lazygit_cmd = 'lazygit',
      neomutt_cmd = 'neomutt',
      taskwarrior_cmd = 'taskwarrior-tui',
    },
    -- Mappings used with the plugin
    mappings = {
      vert_split = '<C-V>',
      horz_split = '<C-S>',
      tabedit = '<C-T>',
      edit = '<C-E>',
      ESC = '<ESC>',
    },
    -- Path to broot config
    broot_conf = '~/.config/broot/conf.hjson',
  }
}
