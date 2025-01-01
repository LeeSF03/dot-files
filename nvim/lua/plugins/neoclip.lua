return {
  "AckslD/nvim-neoclip.lua",
  dependencies = {
    {'kkharji/sqlite.lua', module = 'sqlite'},
    {'nvim-telescope/telescope.nvim'},
  },
  config = function()
    require("config.neoclip")
  end,
  event = {
    'BufReadPre',
    'BufNewFile'
  },
}
