return {
  'mrjones2014/smart-splits.nvim',
  -- TODO: move everything from config.smartsplits to here
  config = function()
    require("config.smartsplits")
  end,
  event = "VeryLazy",
}
