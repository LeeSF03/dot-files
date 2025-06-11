return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'AndreM222/copilot-lualine',
    },
    -- TODO: move everything from config.lualine to here 
    config = function()
      require("config.lualine")
    end,
    event = {
      'BufReadPost',
      'BufNewFile',
    }
  },
}
