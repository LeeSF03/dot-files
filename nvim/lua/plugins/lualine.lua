return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      "ofseed/copilot-status.nvim",
    },
    config = function()
      require("config.lualine")
    end,
    event = {
      'BufReadPost',
      'BufNewFile',
    }
  },
}
