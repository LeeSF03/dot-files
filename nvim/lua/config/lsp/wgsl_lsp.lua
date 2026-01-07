vim.lsp.config("wgsl-analyzer", {
	cmd = { "wgsl-analyzer" },
	filetypes = { "wgsl" },
	root_markers = { ".git" },
	settings = {},
})
vim.lsp.enable("wgsl-analyzer")
