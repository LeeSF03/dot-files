return {
  "RRethy/vim-illuminate",
  config = function()
    require("config.illuminate")
  end,
  event = {
    'BufReadPre',
    'BufNewFile'
  },
}
