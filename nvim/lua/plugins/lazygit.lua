-- nvim v0.8.0
return {
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		keys = {
      -- stylua: ignore start
      { "<leader>lg", mode = { "n" }, "<CMD>LazyGit<CR>", desc = "LazyGit" },
			-- stylua: ignore end
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		init = function()
			vim.api.nvim_set_hl(0, "LazyGitBorder", { fg = "#585b70" })
		end,
	},
}
