return {
  'tpope/vim-dadbod',
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- local smartsplits = require('smart-splits')

      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
      vim.api.nvim_set_hl(0, "NotificationInfo", { fg = "#cdd6f4", bg = "#1e1e2e" })
      vim.api.nvim_set_hl(0, "NotificationWarning", { fg = "#f9e2af", bg = "#1e1e2e" })
      vim.api.nvim_set_hl(0, "NotificationError", { fg = "#f38ba8", bg = "#1e1e2e" })
    end,
  },
}
