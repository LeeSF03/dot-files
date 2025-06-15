return {
  "j-hui/fidget.nvim",
  opts = {
    notification = {
      window = {
        winblend = 0,
        border = 'rounded',
      },
      -- override_vim_notify = true,
      -- filter = vim.log.levels.TRACE,
    },
  },
  event = {
    "BufReadPost",
    "BufNewFile"
  },
}
