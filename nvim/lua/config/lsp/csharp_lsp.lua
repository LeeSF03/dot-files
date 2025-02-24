local lspconfig = require("lspconfig")
local blink = require("blink.cmp")
local capabilities = blink.get_lsp_capabilities()

-- csharp language server setup
lspconfig.omnisharp.setup({
  capabilities = capabilities,
})

