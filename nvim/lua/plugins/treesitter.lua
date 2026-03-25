return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		cmd = { "TSUpdate", "TSInstall", "TSUninstall" },
		event = { "BufReadPre", "BufNewFile" },
		main = "nvim-treesitter.configs",
		---@diagnostic disable-next-line: missing-fields
		opts = {
			ensure_installed = {
				-- lua
				"lua",

				-- web
				"javascript",
				"html",
				"typescript",
				"tsx",
				"css",
				"json",

				-- doc
				"markdown",
				"markdown_inline",

				-- format
				"xml",
				"yaml",
				"toml",

				"c",
				"cpp",
				"go",
				"rust",
				"c_sharp",

				"php",

				"powershell",

				"nginx",

				"sql",

				"wgsl",
			},
			highlight = { enable = true },
			indent = { enable = true },
			playground = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.install").compilers = { "zig", "clang", "gcc" }
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
