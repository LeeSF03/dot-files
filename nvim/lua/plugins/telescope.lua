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
		config = function()
			local builtin = require("telescope.builtin")
			local telescope = require("telescope")
			local actions = require("telescope.actions")

      -- stylua: ignore start
      vim.keymap.set("n", "<leader>ff", builtin.find_files,                                   { desc = "Telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep,                                    { desc = "Telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers,                                      { desc = "Telescope buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags,                                    { desc = "Telescope help tags" })
      vim.keymap.set("n", "<leader>fc", builtin.commands,                                     { desc = "Telescope commands" })
      vim.keymap.set("n", "<leader>gf", builtin.git_files,                                    { desc = "Telescope find git tracked files" })
      vim.keymap.set("n", "<leader>fm", function() builtin.marks({ mark_type = "local"}) end, { desc = "Telescope find marks" })
      vim.keymap.set("n", "<leader>fd", builtin.diagnostics,                                  { desc = "Telescope find diagnostics" })
      vim.keymap.set("n", "<leader>ft", "<CMD>TodoTelescope<CR>",                             { desc = "Telescope find todos" })
			-- stylua: ignore end

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
