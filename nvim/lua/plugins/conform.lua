return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		opts = {
			-- Available formatters: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
			formatters_by_ft = {
				-- INFO: restart prettierd if there was an error that is not caused by the config

				-- web
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				graphql = { "prettierd", "prettier", stop_after_first = true },

				-- yaml
				yaml = { "prettierd", "prettier", stop_after_first = true },

				-- python
				python = { "ruff_format" },

				-- golang
				go = { "gofumpt" },

				-- lua
				lua = { "stylua" },
			},
			formatters = {
				prettier = {
					command = "C:/Users/shuen/.bun/bin/prettier.exe",
				},
				prettierd = {
					command = "C:/Users/shuen/.bun/bin/prettierd.exe",
				},
			},
		},
		config = function(_, opts)
			require("conform").setup(opts)

			vim.api.nvim_create_autocmd({ "BufWritePre" }, {
				pattern = "*",
				callback = function(args)
					require("conform").format({ bufnr = args.buf })
				end,
			})
		end,
	},
}
