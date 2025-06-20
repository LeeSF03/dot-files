return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      require("config.telescope")
    end,
    event = 'VeryLazy',
    cmd = 'Telescope',
  },
  -- {
  --   'nvim-telescope/telescope-ui-select.nvim',
  --   event = 'VeryLazy',
  -- },
}
