return {
  "j-hui/fidget.nvim",
  config = function()
    require("config.fidget")
  end,
  event = {
    "BufReadPost",
    "BufNewFile"
  },
}
