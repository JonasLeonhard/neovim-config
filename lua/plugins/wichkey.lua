return {
  pack = {
    src = 'https://github.com/folke/which-key.nvim',
  },
  lazy = {
    "which-key.nvim",
    event = 'DeferredUIEnter',
    after = function()
      require("which-key").setup({
        preset = 'classic',
        show_help = false,
        spec = {
          -- normal mode
          {
            mode = 'n',
            { '<A-Down>',  ':resize +2<CR>',          desc = 'resize' },
            { '<A-Left>',  ':vertical resize -2<CR>', desc = 'resize' },
            { '<A-Right>', ':vertical resize +2<CR>', desc = 'resize' },
            { '<A-Up>',    ':resize -2<CR>',          desc = 'resize arrow key' },
            { '<C-j>',     '<cmd>:m .+1<cr>==',       desc = 'Move line down' },
            { '<C-k>',     '<cmd>:m .-2<cr>==',       desc = 'Move line up' },
            { '<C-s>',     '<C-a>',                   desc = 'Increment' },
            { '<C-x>',     '<C-x>',                   desc = 'Decrement' },
            { '<ESC>',     '<cmd>:noh <cr>',          desc = 'clear highlights' },
          },

          -- visual mode
          {
            mode = 'v',
            { '<',     '<gv',              desc = 'indent left' },
            { '>',     '>gv',              desc = 'indent right' },
            { '<C-j>', ":m '>+1<CR>gv-gv", desc = 'move lines down' },
            { '<C-k>', ":m '<-2<CR>gv-gv", desc = 'move lines up' },
          },

          -- nv keymaps
          {
            mode = { 'n', 'v' },
            {
              'K',
              function()
                vim.lsp.buf.hover()

                local lspStatus = vim.lsp.status();
                if lspStatus ~= '' then
                  if #lspStatus > 100 then
                    lspStatus = string.sub(lspStatus, 1, 100) .. "..."
                  end
                  vim.notify(lspStatus, vim.log.levels.INFO, {})
                else
                end
              end,
              desc = 'Hover Documentation'
            },
            { '<C-,>', vim.lsp.buf.signature_help, desc = 'Signature Documentation' },
          },

          -- goto group
          {
            mode = { 'n', 'v' },
            { 'gd', vim.lsp.buf.definition,     desc = 'Goto Definition' },
            {
              'gD',
              desc = 'Goto Declaration / Type Definitition',
              { 'gDd', vim.lsp.buf.declaration,     desc = 'Goto Declaration' },
              { 'gDD', vim.lsp.buf.type_definition, desc = 'Goto Type definition' },
            },
            { 'gi', vim.lsp.buf.implementation, desc = 'Goto implementation' },
          },

          -- buffer group
          { '<leader>b', desc = 'buffer', mode = { 'n', 'v' } },
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

          -- code group,
          {
            '<leader>c',
            desc = 'code',
            mode = { 'n', 'v' },
            { '<leader>cd', vim.diagnostic.open_float, desc = 'Open floating diagnostic message' },
            { '<leader>cL', vim.diagnostic.setloclist, desc = 'Open diagnostic list' },
            { '<leader>cr', vim.lsp.buf.rename,        desc = 'Rename' },
            { '<leader>ca', vim.lsp.buf.code_action,   desc = 'Code Action' },
          },

          -- debug group
          {
            '<leader>d',
            desc = 'debug',
            mode = { 'n', 'v' },
          },

          -- search group
          {
            '<leader>s',
            desc = 'search/replace',
            mode = { 'n', 'v' },
          },

          -- toggle group
          {
            '<leader>u',
            desc = 'Ui-Toggles',
            mode = { 'n', 'v' },
            { '<leader>ug', desc = 'git' },
            {
              '<leader>ub',
              desc = 'buffer',
              { '<leader>ubN', '<cmd> set nu! <CR>',  desc = 'toggle line number' },
              { '<leader>ubn', '<cmd> set rnu! <CR>', desc = 'toggle relative line number' },
            },
            { '<leader>uf', '<cmd>:ToggleAutoFormat<cr>', desc = 'toggle autoformat on save' },
            { '<leader>ul', '<cmd>:ToggleAutoLint<cr>',   desc = 'toggle autolint on save/insert leave/bufreadpost' },
            { '<leader>ui', '<cmd>:ToggleInlayHints<cr>', desc = 'toggle inlay hints' },
            { '<leader>ut', '<cmd>split | terminal<cr>',  desc = 'toggle terminal split' },
          },

          -- multicursor
          {
            '<leader>v',
            desc = 'Multicursor',
            mode = { 'n', 'v' },
          },
        },
      })
    end
  }
}
