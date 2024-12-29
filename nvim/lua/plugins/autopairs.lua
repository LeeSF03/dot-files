return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = function()
    require("config.autopairs")
  end,
  -- use opts = {} for passing setup options
  -- this is equivalent to setup({}) function
}
