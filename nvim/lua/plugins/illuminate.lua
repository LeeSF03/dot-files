return {
  "RRethy/vim-illuminate",
  config = function()
    require("config.illuminate")
  end,
  event = {
    "BufReadPost",
    "BufNewFile"
  },
}
