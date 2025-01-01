local blink = require("blink.cmp")

blink.setup({
  keymap = {
    ['<C-s>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<C-e>'] = { 'hide' },
    ['<C-y>'] = { 'select_and_accept' },

    -- ['<C-k>'] = { 'select_prev', 'fallback' },
    -- ['<C-j>'] = { 'select_next', 'fallback' },

    ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
    ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
  },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
  },
  completion = {
    menu = {
      border = 'rounded',
    },
    documentation = {
      window = {
        border = 'rounded',
      },
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },
  -- experimental signature help support
  signature = { enabled = true, window = { border = 'rounded' } },
})

-- Set autocomplete highlight
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#1e1e2e", })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#ea76cb" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "#1e1e2e", })
vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#89b4fa", bg = "#1e1e2e" }) -- not working
