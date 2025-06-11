return {
  {
    'lewis6991/gitsigns.nvim',
    -- TODO: move everything from config.gitsigns to here
    config = function()
      require("config.gitsigns")
    end,
    event = {
      'BufReadPost',
      'BufNewFile'
    },
  }
}
