return {
  'windwp/nvim-ts-autotag',
  config = function()
    require("config.autotag")
  end,
  event = {
    "InsertEnter",
  },
}
