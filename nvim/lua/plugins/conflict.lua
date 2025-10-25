-- Catppuccin Mocha colors
local colors = {
	text = "#cdd6f4",
	base = "#1e1e2e",
	surface0 = "#313244",
	surface1 = "#45475a",
	red = "#f38ba8",
	green = "#a6e3a1",
	blue = "#89b4fa",
	overlay0 = "#6c7086",
}

-- Labels (conflict markers: <<<<<<<, |||||||, >>>>>>>)
vim.api.nvim_set_hl(0, "GitConflictCurrentLabel", { fg = colors.base, bg = colors.red, bold = true })
vim.api.nvim_set_hl(0, "GitConflictIncomingLabel", { fg = colors.base, bg = colors.green, bold = true })
vim.api.nvim_set_hl(0, "GitConflictAncestorLabel", { fg = colors.text, bg = colors.surface1, bold = true })

-- Content blocks (solid background colors)
vim.api.nvim_set_hl(0, "GitConflictCurrent", { bg = "#2e1e21", fg = colors.text }) -- darker red variant
vim.api.nvim_set_hl(0, "GitConflictIncoming", { bg = "#22322b", fg = colors.text }) -- darker green variant
vim.api.nvim_set_hl(0, "GitConflictAncestor", { bg = colors.surface1, fg = colors.text }) -- close to background
vim.api.nvim_set_hl(0, "GitConflictBase", { bg = colors.surface0, fg = colors.text }) -- neutral gray

return {
	"akinsho/git-conflict.nvim",
	version = "*",
	config = true,
	event = "BufReadPost",
	highlights = {
		current = "GitConflictCurrent",
		incoming = "GitConflictIncoming",
	},
}
