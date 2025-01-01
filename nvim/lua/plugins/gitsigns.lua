return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require("config.gitsigns")
    end,
    event = {
      'BufReadPre',
      'BufNewFile'
    },
  }
}
