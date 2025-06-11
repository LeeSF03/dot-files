return {
  "brenoprata10/nvim-highlight-colors",
  event = {
    "BufReadPost",
    "BufNewFile"
  },
  -- TODO: move everything from config.colorizer to here
  config = function()
    require("config.colorizer")
  end,
}
