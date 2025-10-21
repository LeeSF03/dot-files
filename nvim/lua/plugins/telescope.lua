return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		-- or                              , branch = '0.1.x',
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#1e1e2e", fg = "#89b4fa"  })
			vim.api.nvim_set_hl(0, "TelescopePreviewTitle", { bg = "#1e1e2e" })
			vim.api.nvim_set_hl(0, "TelescopePromptTitle", { bg = "#1e1e2e" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2e" })
			vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1e1e2e", fg = "#89b4fa" })
			require("config.telescope")
		end,
		-- event = 'VeryLazy',
		cmd = "Telescope",
	},
	-- {
	--   'nvim-telescope/telescope-ui-select.nvim',
	--   event = 'VeryLazy',
	-- },
}
