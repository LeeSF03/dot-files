return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  -- TODO: move everything from config.oil to here
  config = function()
    require("config.oil")
  end,
  event = { "VimEnter */*,.*", "BufNew */*,.*" },
  cmd = { 'Oil'},
  -- keys = {
  --   { '-', '<CMD>Oil<CR>', desc = 'Open parent directory' },
  --   { '<leader>-', '<CMD>Oil --float<CR>', desc = 'Open parent directory in floating' },
  -- },
}
