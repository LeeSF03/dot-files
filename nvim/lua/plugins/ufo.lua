return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
    'luukvbaal/statuscol.nvim',
  },
  config = function()
    require("config.ufo")
  end,
  event = {
    'VeryLazy',
    -- 'BufReadPre',
    -- 'BufNewFile'
  },
}
