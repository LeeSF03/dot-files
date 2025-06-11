return {
  'windwp/nvim-ts-autotag',
  -- TODO: move everything from config.autotag to here
  config = function()
    require("config.autotag")
  end,
  -- event = {
  --   "InsertEnter",
  -- },
  ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
}
