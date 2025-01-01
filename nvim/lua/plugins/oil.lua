return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  config = function()
    require("config.oil")
  end,
  -- event = 'VeryLazy',
  keys = {
    { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
    { '<leader>-', '<CMD>Oil --float<CR>', desc = 'Open parent directory in floating' },
  },
}
