return {
  "folke/ts-comments.nvim",
  opts = {},
  event = {
    "InsertEnter",
  },
  enabled = vim.fn.has("nvim-0.10.0") == 1,
}
