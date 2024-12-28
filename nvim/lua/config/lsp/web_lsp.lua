local lspconfig = require("lspconfig")
local blink = require("blink.cmp")
local capabilities = blink.get_lsp_capabilities()

-- typescript language server setup
lspconfig.ts_ls.setup({
  capabilities = capabilities,
})

-- tailwindcss language server setup
lspconfig.tailwindcss.setup({
  capabilities = capabilities,
})

-- cssmodules language server setup
lspconfig.cssmodules_ls.setup({
  capabilities = capabilities,
})

