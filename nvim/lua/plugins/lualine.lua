return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'AndreM222/copilot-lualine',
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
