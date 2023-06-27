return {
  'chentoast/marks.nvim',
  lazy = true,
  keys = {
    { 'm',           desc = "Add mark",           mode = 'n' },
    { '<leader>uM',  '<cmd>MarksToggleSigns<cr>', desc = "Toggle Mark signs" },
    { '<leader>mMa', '<cmd>MarksListAll<cr>',     desc = 'List All' },
    { '<leader>mMb', '<cmd>MarksListBuf<cr>',     desc = 'List Buffer' },
    { '<leader>mMg', '<cmd>MarksListGlobal<cr>',  desc = 'List Global' },
    {
      '<leader>mMh',
      function()
        print('{mx] = set Mark <x>')
        print('[m,] = Set the next alphabetical lowercase mark')
        print('[dmx] = delete mark <x>')
        print('[dm-] = delete all marks on the current line')
        print('[dm<space>] = delete all marks in buffer')
        print('[m]] = move to next mark')
        print('[m[] = move to prev mark')
        print('[m:] = preview mark')
        print('[m0-9] = bookmark from bookmarkgroup')
        print('[dm0-9] = delete bookmark from bookmarkgroup')
        print('[m{] = move to next bookmark')
        print('[m}] = move to prev bookmark')
        print('[dm=] = delete bookmark under cursor')
      end,
      desc = 'Keybind help',
    },
    { '<leader>mMd', '<cmd>:delmarks a-zA-Z0-9<cr>', desc = 'Delete all marks globally' },
  },
  config = function()
    require('marks').setup {
      -- while lower values may cause performance penalties. default 150.
      refresh_interval = 10000,
      -- whether the shada file is updated after modifying marks. default false. Without this cleared marks are reloaded after saving.
      force_write_shada = true,
      sign_priority = 100,
    }
  end,
}
