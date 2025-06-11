return {
  {
    'mfussenegger/nvim-lint',
    event = {
      "BufWritePre",
    },
    -- TODO: move everything from config.lint to here
    config = function()
      require("config.lint")
    end,
  },
}
