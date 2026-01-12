return {
	"ThePrimeagen/git-worktree.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim", -- Optional, but recommended for fuzzy finding
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("telescope").load_extension("git_worktree")
		local Worktree = require("git-worktree")

		local os_name = vim.loop.os_uname().sysname
		if os_name ~= "Windows_NT" then
			Worktree.setup({
				update_on_change_command = "",
			})
			return
		end

		Worktree.on_tree_change(function(op, metadata)
			if op == Worktree.Operations.Switch then
				local current_buf = vim.api.nvim_buf_get_name(0)
				if current_buf == "" then
					return
				end

				-- Normalize current buffer path
				current_buf = current_buf:gsub("\\", "/")

				-- Get Git root of current buffer
				local current_dir = vim.fn.fnamemodify(current_buf, ":h")
				local git_root_cmd = "git -C " .. vim.fn.shellescape(current_dir) .. " rev-parse --show-toplevel"
				local git_root = vim.fn.system(git_root_cmd)

				if vim.v.shell_error ~= 0 then
					return
				end
				git_root = vim.trim(git_root):gsub("\\", "/")

				-- Get relative path
				local relative_path = current_buf:gsub(git_root, ""):sub(2)

				-- Handle case-insensitivity for Windows
				if relative_path == current_buf then
					local lower_buf = current_buf:lower()
					local lower_root = git_root:lower()
					if lower_buf:find(lower_root, 1, true) == 1 then
						relative_path = current_buf:sub(#git_root + 2)
					else
						return -- Not in git root
					end
				end

				-- Construct new path
				local new_root = metadata.path:gsub("\\", "/")
				local new_file_path = new_root .. "/" .. relative_path

				-- Switch directory and open file if it exists
				if vim.fn.filereadable(new_file_path) == 1 then
					vim.schedule(function()
						vim.cmd("cd " .. new_root)
						vim.cmd("e " .. vim.fn.fnameescape(new_file_path))
					end)
				else
					vim.schedule(function()
						vim.cmd("cd " .. new_root)
						vim.notify(
							"Worktree switched. File not found in new worktree: " .. new_file_path,
							vim.log.levels.WARN
						)
					end)
				end
			end
		end)

		Worktree.setup({
			update_on_change = false,
		})
	end,
	keys = {
    -- stylua: ignore start
    {"<leader>ww", function() require("telescope").extensions.git_worktree.git_worktrees() end, desc = "Manage Git Worktrees"},
		-- {"<leader>wc", function() require("telescope").extensions.git_worktree.create_git_worktree() end, desc = "Create Git Worktree"},
		-- stylua: ignore end
	},
}
