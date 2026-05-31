vim.lsp.config("terraformls", {
	cmd = { "terraform-ls", "serve" },
	filetypes = { "terraform", "terraform-vars" },
	root_markers = { ".terraform", ".git" },
})
vim.lsp.enable("terraformls")
