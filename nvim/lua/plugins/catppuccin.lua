return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    transparent_background = true,
    integrations = { blink_cmp = true },
  },
  init = function()
    vim.cmd.colorscheme "catppuccin-mocha"
  end,
}
