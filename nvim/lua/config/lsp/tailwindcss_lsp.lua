local lspconfig = require("lspconfig")
local blink = require("blink.cmp")
local capabilities = blink.get_lsp_capabilities()

-- tailwindcss language server setup
lspconfig.tailwindcss.setup({
  capabilities = capabilities,
  -- cmd = { "bun", "~\\.bun\\install\\global\\node_modules\\@tailwindcss\\language-server\\bin\\tailwindcss-language-server", "--stdio" },
  cmd = { "tailwindcss-language-server", "--stdio" },
})
