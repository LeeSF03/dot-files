vim.filetype.add({
	extension = { conf = "nginx" },
	filename = { ["nginx.conf"] = "nginx" },
	pattern = { [".*/nginx/.*%.conf"] = "nginx" },
})

vim.lsp.config("nginx-language-server", {
	cmd = { "nginx-language-server" },
	filetypes = { "nginx" },
	root_markers = { "nginx.conf", ".git" },
})
vim.lsp.enable("nginx-language-server")
