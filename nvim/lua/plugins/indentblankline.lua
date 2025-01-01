return {
  "lukas-reineke/indent-blankline.nvim",
  config = function()
    require("config.indentblankline")
  end,
  event = {
    "BufReadPre",
    "BufNewFile"
  },
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
}
