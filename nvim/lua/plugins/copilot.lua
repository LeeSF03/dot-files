return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = {
			"InsertEnter",
		},
		config = function(_, opts)
			require("copilot").setup(opts)
		end,
		opts = {
			suggestion = {
				enabled = false,
				-- auto_trigger = true,
				-- keymap = {
				-- 	accept = "<Tab>",
				-- 	next = "<A-n>",
				-- 	prev = "<A-p>",
				-- 	dismiss = "<C-c>",
				-- },
			},
			panel = {
				enabled = false,
				auto_refresh = true,
			},
		},
	},
}
