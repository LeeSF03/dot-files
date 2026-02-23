return {
	"j-hui/fidget.nvim",
	opts = {
		notification = {
			window = {
				winblend = 0,
				border = "rounded",
			},
		},
	},
	event = {
		"BufReadPost",
		"BufNewFile",
	},
}
