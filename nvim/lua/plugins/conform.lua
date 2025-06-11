return {
  {
    'stevearc/conform.nvim',
    event = {
      "BufWritePre",
    },
    opts = {},
    -- TODO: move everything from config.conform to here
    config = function()
      require("config.conform")
    end,
  },
}
