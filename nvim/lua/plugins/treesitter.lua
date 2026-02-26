return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cmd = { "TSUpdate", "TSInstall" },
		event = { "BufReadPre", "BufNewFile" },
		main = "nvim-treesitter.configs",
		---@diagnostic disable-next-line: missing-fields
		opts = {
			ensure_installed = {
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
			},
			highlight = { enable = true },
			indent = { enable = true },
			playground = { enable = true },
		},
	},
}
