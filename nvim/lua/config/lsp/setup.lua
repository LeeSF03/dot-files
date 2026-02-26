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

-- stylua: ignore start
vim.api.nvim_set_hl(0, "NormalFloat",        { bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "FloatBorder",        { fg = "#89b4fa", bg = "#1e1e2e" })
vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = "#1e1e2e" })
-- stylua: ignore end
