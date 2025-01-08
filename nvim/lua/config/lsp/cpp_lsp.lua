local lspconfig = require("lspconfig")
local blink = require("blink.cmp")
local capabilities = blink.get_lsp_capabilities()

lspconfig.clangd.setup({
  capabilities = capabilities,
})
