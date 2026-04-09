return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
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
			enable_highlight = true,
			enable_indent = true,
		},
		config = function(_, opts)
			require("nvim-treesitter.install").compilers = { "zig", "clang", "gcc" }
			local treesitter = require("nvim-treesitter")

			treesitter.setup()

			local group = vim.api.nvim_create_augroup("treesitter-setup", { clear = true })
			local function attach(buf)
				if not (opts.enable_highlight or opts.enable_indent) then
					return
				end

				local ok = pcall(vim.treesitter.start, buf)
				if ok and opts.enable_indent then
					vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end

			vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
				group = group,
				callback = function(args)
					attach(args.buf)
				end,
			})
		end,
	},
}
