return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
    'luukvbaal/statuscol.nvim',
  },
  -- TODO: move everything from config to here
  config = function()
    require("config.ufo")
  end,
  event = {
    'VeryLazy',
    -- 'BufReadPost',
    -- 'BufNewFile'
  },
}
