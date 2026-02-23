local mason = require("mason")
local masontoolinstaller = require("mason-tool-installer")

mason.setup({
	ui = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},
})

-- list of tools(linters, formatters, etc):
-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
masontoolinstaller.setup({
	ensure_installed = {
		-- web
		-- use bun installed instead for prettier and prettierd
		"prettier",
		"prettierd",
		"eslint_d",

		-- python
		"ruff",

		-- golang
		"golangci-lint",
		"gofumpt",
		"golines",

		-- lua
		"stylua",
	},
})

-- Disable diagnostic signs
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})

local orig_util = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
	opts = opts or {}
	opts.border = opts.border or "rounded"
	return orig_util(contents, syntax, opts, ...)
end

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#1e1e2e" })
