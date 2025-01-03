return {
  "catgoose/nvim-colorizer.lua",
  event = {
    "BufReadPre", "BufNewFile"
  },
  config = function()
    require("config.colorizer")
  end,
}
