return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "Gitsigns" },
	-- stylua: ignore start
	keys = {
    { "+", mode = { "n" },function() require("gitsigns").preview_hunk_inline() end, desc = "Preview diff hunk inline" }
  },
	-- stylua: ignore end
	opts = {
		current_line_blame = true,
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
	},
}
