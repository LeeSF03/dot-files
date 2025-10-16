local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5 -- You can change this too

return {
	"stevearc/oil.nvim",
	---@module 'oil'
	---@type oil.SetupOpts
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	init = function()
		vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#1e1e2e" })
	end,
	opts = {
		default_file_explorer = true,
		delete_to_trash = true,
		view_options = {
			show_hidden = true,
		},
		keymaps = {
			["q"] = { "actions.close", mode = "n" },
			["<C-p>"] = "actions.preview",
		},
		preview_win = {
			-- Whether the preview window is automatically updated when the cursor is moved
			update_on_cursor_moved = true,
			-- How to open the preview window "load"|"scratch"|"fast_scratch"
			preview_method = "fast_scratch",
			-- A function that returns true to disable preview on a file e.g. to avoid lag
			disable_preview = function(filename)
				return false
			end,
			-- Window-local options to use for preview window buffers
			win_options = {},
		},
		float = {
			override = function()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
				local window_w = screen_w * WIDTH_RATIO
				local window_h = screen_h * HEIGHT_RATIO
				local window_w_int = math.floor(window_w)
				local window_h_int = math.floor(window_h)
				local center_x = (screen_w - window_w) / 2
				local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
				return {
					border = "rounded",
					relative = "editor",
					row = center_y,
					col = center_x,
					width = window_w_int,
					height = window_h_int,
				}
			end,
		},
	},
	event = {
		"VimEnter */*,.*",
		"BufNew */*,.*",
	},
	cmd = { "Oil" },
	keys = {
		{ "-", "<CMD>Oil<CR>", desc = "Open parent directory" },
		{ "<leader>-", "<CMD>Oil --float<CR>", desc = "Open parent directory in floating" },
	},
}
