return {
  "RRethy/vim-illuminate",
  -- TODO: move everything from config.illuminate to here
  config = function()
    require("config.illuminate")
  end,
  event = {
    "BufReadPost",
    "BufNewFile"
  },
}
