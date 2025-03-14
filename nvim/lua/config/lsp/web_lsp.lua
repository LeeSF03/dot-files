local lspconfig = require("lspconfig")
local blink = require("blink.cmp")
local capabilities = blink.get_lsp_capabilities()

-- typescript language server setup
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  cmd = { "typescript-language-server", "--stdio" },
})

-- cssmodules language server setup
lspconfig.cssmodules_ls.setup({
  capabilities = capabilities,
})

-- biome language server setup
lspconfig.biome.setup({
  capabilities = capabilities,
})
