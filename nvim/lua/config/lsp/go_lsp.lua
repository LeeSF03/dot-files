local lspconfig = require("lspconfig")
local blink = require("blink.cmp")
local capabilities = blink.get_lsp_capabilities()

-- golang language server setup
lspconfig.gopls.setup({
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,
    }
  }
})

local go_format_group = vim.api.nvim_create_augroup("GoFormat", { clear = true })

vim.cmd("let g:go_fmt_command = 'golines'")
vim.cmd("let g:go_fmt_options = { 'golines': '-m 128' }")

vim.api.nvim_create_autocmd({ "BufWritePre", "InsertLeave" }, {
  group = go_format_group,
  callback = function(args)
    vim.lsp.buf.format({ bufnr = args.buf })
  end,
})

