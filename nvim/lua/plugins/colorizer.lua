return {
  "catgoose/nvim-colorizer.lua",
  event = {
    "BufReadPost",
    "BufNewFile"
  },
  config = function()
    require("config.colorizer")
  end,
}
