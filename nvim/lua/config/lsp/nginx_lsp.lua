local lspconfig = require("lspconfig")
local blink = require("blink.cmp")
local capabilities = blink.get_lsp_capabilities()

lspconfig.nginx_language_server.setup({
  capabilities = capabilities,
})

