return {
  "j-hui/fidget.nvim",
  -- TODO: move everything from config.fidget to here
  config = function()
    require("config.fidget")
  end,
  event = {
    "BufReadPost",
    "BufNewFile"
  },
}
