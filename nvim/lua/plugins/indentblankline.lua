return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = { char = "│" },
		exclude = {
			filetypes = { "help", "lazy", "undotree", "nvimtree", "dashboard", "oil", "harpoon", "lazygit" },
			buftypes = { "terminal", "nofile", "quickfix" },
		},
	},
}
