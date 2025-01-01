return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("config.toggleterm")
    end,
    event = "VeryLazy",
  },
}
