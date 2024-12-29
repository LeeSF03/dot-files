return {
  {
    'mfussenegger/nvim-lint',
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      require("config.lint")
    end,
  },
}
