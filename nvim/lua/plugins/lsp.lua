return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("config.lsp")
		end,
		event = { "BufReadPre", "BufNewFile" },
		cmd = {
			"MasonInstall",
			"MasonUninstall",
			"MasonUpdate",
			"Mason",
			"MasonLog",
		},
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v0.*",
		opts_extend = { "sources.default" },
		event = {
			"InsertEnter",
			"CmdlineEnter",
		},
		config = function()
			require("config.lsp.blink")
		end,
	},
	{
		"giuxtaposition/blink-cmp-copilot",
		dependencies = {
			"zbirenbaum/copilot.lua",
			"saghen/blink.cmp",
		},
		event = {
			"InsertEnter",
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- optional
			"nvim-tree/nvim-web-devicons", -- optional
		},
		event = {
			-- "BufReadPre",
			-- "BufNewFile",
			"LspAttach",
		},
		config = function()
			require("config.lsp.lspsaga")
		end,
	},
	{
		"rachartier/tiny-code-action.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		event = "LspAttach",
		keys = {
			{
				"<leader>ca",
				mode = { "n", "x", "o" },
				function()
					require("tiny-code-action").code_action()
				end,
				desc = "Code Action",
			},
		},
		opts = {},
	},
}
