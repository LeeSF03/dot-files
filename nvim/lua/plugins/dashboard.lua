return {
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require("config.dashboard")
    end,
    dependencies = { {'nvim-tree/nvim-web-devicons'}}
  }
}
