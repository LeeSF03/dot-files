local languages = {
	"lua",

	"javascript",
	"html",
	"typescript",
	"tsx",
	"css",
	"json",

	"markdown",
	"markdown_inline",

	"c",
	"cpp",
	"go",
	"c_sharp",
	"php",

	"xml",
	"yaml",
	"powershell",
	"nginx",
	"sql",

	"wgsl",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cmd = { "TSUpdate" },
		ft = languages,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = languages,
				highlight = { enable = true },
				indent = { enable = true },
				playground = { enable = true },
			})
		end,
	},
}
