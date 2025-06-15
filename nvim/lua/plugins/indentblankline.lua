return {
  "lukas-reineke/indent-blankline.nvim",
  opts = {
    indent = {
      char = "│",
    },
    exclude = {
      filetypes = { 'help', 'lazy', 'nvimtree', 'dashboard', 'oil' },
      buftypes = { 'terminal', 'nofile', 'quickfix' },
    },
  },
  event = {
    "BufReadPost",
    "BufNewFile"
  },
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
}
