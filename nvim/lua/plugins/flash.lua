return {
  "folke/flash.nvim",
  event = "BufReadPre",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o", "v" }, function() require("flash").jump() end,       desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  },
}
