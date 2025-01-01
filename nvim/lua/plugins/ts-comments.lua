return {
  "folke/ts-comments.nvim",
  opts = {},
  event = {
    'BufReadPre',
    'BufNewFile',
  },
  enabled = vim.fn.has("nvim-0.10.0") == 1,
}
