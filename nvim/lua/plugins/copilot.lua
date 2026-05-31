return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			should_attach = function(_, _)
				return false
			end,
			suggestion = { enabled = false },
			panel = {
				enabled = false,
				auto_refresh = true,
			},
		},
	},
}
