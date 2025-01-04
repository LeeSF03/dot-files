return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      require("config.treesitter")
    end,
  },
}
