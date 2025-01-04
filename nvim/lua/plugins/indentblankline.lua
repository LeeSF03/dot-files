return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("config.indentblankline")
  end,
  event = {
    "BufReadPost",
    "BufNewFile"
  },
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
}
