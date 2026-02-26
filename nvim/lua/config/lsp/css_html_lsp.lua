vim.lsp.config("cssmodules_ls", {
	cmd = { "cssmodules-language-server" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "package.json" },
})
vim.lsp.enable("cssmodules_ls")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config("cssls", {
	capabilities = capabilities,
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
	root_markers = { "package.json", ".git" },
	settings = {
		css = {
			validate = true,
			lint = { unknownAtRules = "ignore" },
		},
		scss = {
			validate = true,
			lint = { unknownAtRules = "ignore" },
		},
		less = {
			validate = true,
			lint = { unknownAtRules = "ignore" },
		},
	},
})
vim.lsp.enable("cssls")

vim.lsp.config("html", {
	capabilities = capabilities,
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "templ", "svg" },
	root_markers = { "package.json", ".git" },
	settings = {},
	init_options = {
		provideFormatter = true,
		embeddedLanguages = { css = true, javascript = true },
		configurationSection = { "html", "css", "javascript" },
	},
})
vim.lsp.enable("html")
