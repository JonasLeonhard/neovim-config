return {
  'NMAC427/guess-indent.nvim',
  event = 'VeryLazy',
  lazy = true,
  config = function()
    require('guess-indent').setup {
      auto_cmd = false, -- we create our own toggle for the autocmd
      filetype_exclude = { -- A list of filetypes for which the auto command gets disabled
        'netrw',
        'tutor',
        'alpha',
      },
    }

    local guess_indent_on = true

    vim.api.nvim_create_user_command('ToggleGuessIndent', function()
      guess_indent_on = not guess_indent_on
    end, {})

    _GuessIndentEnabled = function()
      return guess_indent_on
    end

    vim.api.nvim_create_autocmd('BufEnter', {
      callback = function()
        if guess_indent_on then
          vim.cmd 'silent GuessIndent auto_cmd .'
        end
      end,
    })
  end,
}
