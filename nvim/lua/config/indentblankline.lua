require("ibl").setup({
  indent = {
    char = "│",
  },
  exclude = {
    filetypes = { 'help', 'lazy', 'nvimtree', 'dashboard', 'oil' },
    buftypes = { 'terminal', 'nofile', 'quickfix' },
  },
})
