local telescope_builtin = require("telescope.builtin")

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local lspsaga = require("lspsaga")
		lspsaga.setup({
			code_action = {
				keys = {
					quit = "q",
					exec = "<CR>",
				},
			},
			definition = {
				keys = {
					quit = "q",
				},
			},
			rename = {
				keys = {
					quit = "<ESC>",
					exec = "<CR>",
				},
				in_select = false,
			},
		})

		-- diagnostics
    -- stylua: ignore start
		vim.keymap.set("n", "gsc", "<CMD>Lspsaga show_cursor_diagnostics<CR>", { desc = "Show cursor diagnostics", buffer = ev.buf })
		vim.keymap.set("n", "gss", "<CMD>Lspsaga show_line_diagnostics<CR>", { desc = "Show line diagnostics", buffer = ev.buf })
		vim.keymap.set("n", "gsb", "<CMD>Lspsaga show_buf_diagnostics<CR>", { desc = "Show buffer diagnostics", buffer = ev.buf })
		vim.keymap.set("n", "gsw", "<CMD>Lspsaga show_workspace_diagnostics<CR>", { desc = "Show workplace diagnostics", buffer = ev.buf })
		vim.keymap.set("n", "gsN", "<CMD>Lspsaga diagnostic_jump_prev<CR>", { desc = "Jump to previous diagnostic", buffer = ev.buf })
		vim.keymap.set("n", "gsn", "<CMD>Lspsaga diagnostic_jump_next<CR>", { desc = "Jump to next diagnostic", buffer = ev.buf })

		-- disable default lsp keymaps
		pcall(vim.keymap.del, "n", "grn")
		pcall(vim.keymap.del, "n", "gra")
		pcall(vim.keymap.del, "n", "grr")
		pcall(vim.keymap.del, "n", "gri")

		-- definition
		vim.keymap.set("n", "gp", "<CMD>Lspsaga peek_definition<CR>", { desc = "Peek defenition", buffer = ev.buf })
		vim.keymap.set("n", "gd", "<CMD>Lspsaga goto_definition<CR>", { desc = "Go to defenition", buffer = ev.buf })
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration", buffer = ev.buf })
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation", buffer = ev.buf })
		vim.keymap.set( "n", "<leader>gr", telescope_builtin.lsp_references, { desc = "Go to references", buffer = ev.buf })

		vim.keymap.set("n", "<leader>rn", "<CMD>Lspsaga rename<CR>", { desc = "Rename variable", buffer = ev.buf })

		-- using tiny-code-action.nvim for code actions
		-- vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions", buffer = ev.buf })
		-- stylua: ignore end

		vim.keymap.set("n", "<leader>cf", function()
			vim.lsp.buf.format({ async = true })
		end, { desc = "Code Format", buffer = ev.buf })
	end,
})
