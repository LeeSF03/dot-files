local lspconfig = require("lspconfig")
local blink = require("blink.cmp")
local capabilities = blink.get_lsp_capabilities()

lspconfig.dockerls.setup({
  capabilities = capabilities,
})

lspconfig.docker_compose_language_service.setup({
  capabilities = capabilities,
})
