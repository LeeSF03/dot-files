return {
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufWritePre",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				-- web
				typescript = { "eslint_d" },
				javascript = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				javascriptreact = { "eslint_d" },

				-- python
				python = { "ruff" },

				-- golang
				go = { "golangcilint" },
			}

			-- Available Linters: https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},
}
