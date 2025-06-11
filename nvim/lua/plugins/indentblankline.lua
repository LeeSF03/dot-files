return {
  "lukas-reineke/indent-blankline.nvim",
  -- TODO: move everything from config.indentblankline to here
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
