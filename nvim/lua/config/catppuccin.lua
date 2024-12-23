local catppuccin = require("catppuccin")

catppuccin.setup({
  transparent_background = true,
  integrations = { blink_cmp = true },
})

vim.cmd.colorscheme "catppuccin-mocha"
