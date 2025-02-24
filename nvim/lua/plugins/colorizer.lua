return {
  "brenoprata10/nvim-highlight-colors",
  event = {
    "BufReadPost",
    "BufNewFile"
  },
  config = function()
    require("config.colorizer")
  end,
}
