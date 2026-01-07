return {
	"LeeSF03/undotree",
	init = function()
		vim.g.undotree_WindowLayout = 3
		vim.g.undotree_SplitWidth = 30
		vim.g.undotree_DiffpanelHeight = 10
		vim.g.undotree_SetFocusWhenToggle = 1
		vim.g.undotree_ShortIndicators = 1
	end,
	cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotreePersistUndo" },
	keys = {
		{ "U", "<CMD>UndotreeToggle<CR>", desc = "Toggle undo tree" },
	},
}
