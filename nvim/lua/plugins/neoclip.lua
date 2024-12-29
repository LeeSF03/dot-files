return {
  "AckslD/nvim-neoclip.lua",
  lazy = true,
  dependencies = {
    {'kkharji/sqlite.lua', module = 'sqlite'},
    {'nvim-telescope/telescope.nvim'},
  },
  config = function()
    require("config.neoclip")
  end,
}
