return {
  {
    'stevearc/conform.nvim',
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    opts = {},
    config = function()
      require("config.conform")
    end,
  },
}
