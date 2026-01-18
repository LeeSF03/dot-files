return {
	{
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.8",
		-- or                              , branch = '0.1.x',
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},
		config = function()
			require("config.telescope")
		end,
		cmd = { "Telescope" },
		-- keys = {
		--     -- stylua: ignore start
		-- 	{ "<leader>ff", require("telescope.builtin").find_files, { desc = "Telescope find files" } },
		-- 	{ "<leader>fg", require("telescope.builtin").live_grep, { desc = "Telescope live grep" } },
		-- 	{ "<leader>fb", require("telescope.builtin").buffers, { desc = "Telescope buffers" } },
		-- 	{ "<leader>fh", require("telescope.builtin").help_tags, { desc = "Telescope help tags" } },
		-- 	{ "<leader>fc", require("telescope.builtin").commands, { desc = "Telescope commands" } },
		-- 	{ "<leader>gf", require("telescope.builtin").git_files, { desc = "Telescope find git tracked files" } },
		-- 	{ "<leader>fm", function() require("telescope.builtin").marks({ mark_type = "local" }) end, { desc = "Telescope find marks" } },
		-- 	{ "<leader>fd", require("telescope.builtin").diagnostics, { desc = "Telescope find diagnostics" } },
		-- 	-- stylua: ignore end
		-- },
		-- opts = {
		-- 	pickers = {
		-- 		find_files = {
		-- 			hidden = true,
		-- 			-- find_command = { "fd", "--type", "f", "--no-ignore", "--hidden" },
		-- 			find_command = { "fd", "--type", "f", "--hidden" },
		-- 		},
		-- 		live_grep = {
		-- 			additional_args = function()
		-- 				return { "--hidden" }
		-- 			end,
		-- 		},
		-- 	},
		-- 	defaults = {
		-- 		previewer = true,
		-- 		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		-- 		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		-- 		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- 		layout_startegy = "horizontal",
		-- 		layout_config = {
		-- 			center = {
		-- 				height = 0.80,
		-- 				preview_cutoff = 1,
		-- 				prompt_position = "top",
		-- 				width = 0.80,
		-- 			},
		-- 			horizontal = {
		-- 				preview_cutoff = 1,
		-- 				prompt_position = "bottom",
		-- 			},
		-- 		},
		-- 		mappings = {
		-- 			i = {
		-- 				-- ["<C-j>"] = require("telescope.actions").move_selection_next,
		-- 				-- ["<C-k>"] = require("telescope.actions").move_selection_previous,
		-- 				["<C-c>"] = require("telescope.actions").close,
		--
		-- 				["<C-u>"] = require("telescope.actions").preview_scrolling_up,
		-- 				["<C-d>"] = require("telescope.actions").preview_scrolling_down,
		-- 				["<C-s>"] = require("telescope.actions").select_horizontal,
		-- 				["<C-v>"] = require("telescope.actions").select_vertical,
		-- 				-- ["<C-x>"] = require("telescope.actions").delete_buffer,
		-- 			},
		-- 		},
		-- 	},
		-- 	extensions = {
		-- 		["ui-select"] = {
		-- 			require("telescope.themes").get_dropdown({
		-- 				-- even more opts
		-- 			}),
		-- 		},
		-- 	},
		-- },
	},
}
