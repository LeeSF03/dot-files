return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-telescope/telescope-ui-select.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
			},
		},
		cmd = "Telescope",
		keys = {
        -- stylua: ignore start
        { "<leader>ff", function() require("telescope.builtin").find_files() end,                   desc = "Telescope find files" },
        { "<leader>fg", function() require("telescope.builtin").live_grep() end,                    desc = "Telescope live grep" },
        { "<leader>fb", function() require("telescope.builtin").buffers() end,                      desc = "Telescope buffers" },
        { "<leader>fh", function() require("telescope.builtin").help_tags() end,                    desc = "Telescope help tags" },
        { "<leader>fc", function() require("telescope.builtin").commands() end,                     desc = "Telescope commands" },
        { "<leader>gf", function() require("telescope.builtin").git_files() end,                    desc = "Telescope find git tracked files" },
        { "<leader>fm", function() require("telescope.builtin").marks({ mark_type = "local" }) end, desc = "Telescope find marks" },
        { "<leader>fd", function() require("telescope.builtin").diagnostics() end,                  desc = "Telescope find diagnostics" },
        { "<leader>ft", "<cmd>TodoTelescope<CR>",                                                   desc = "Telescope find todos" },
        { "<leader>gr", function() require("telescope.builtin").lsp_references() end,               desc = "Search references" },
			-- stylua: ignore end
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")

			telescope.setup({
				pickers = {
					find_files = {
						hidden = true,
						find_command = { "fd", "--type", "f", "--hidden" },
					},
					live_grep = {
						additional_args = { "--hidden" },
					},
				},
				defaults = {
					previewer = true,
					file_previewer = require("telescope.previewers").vim_buffer_cat.new,
					grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
					qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
					layout_startegy = "horizontal",
					layout_config = {
						center = {
							height = 0.80,
							preview_cutoff = 1,
							prompt_position = "top",
							width = 0.80,
						},
						horizontal = {
							preview_cutoff = 1,
							prompt_position = "bottom",
						},
					},
					mappings = {
						i = {
							["<C-c>"] = actions.close,

							["<C-u>"] = actions.preview_scrolling_up,
							["<C-d>"] = actions.preview_scrolling_down,
							["<C-s>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
						},
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
					-- https://github.com/nvim-telescope/telescope-fzf-native.nvim?tab=readme-ov-file#telescope-setup-and-configuration
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			telescope.load_extension("fzf")
		end,
		cmd = { "Telescope" },
	},
}
