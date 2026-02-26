return {
	{
		"luukvbaal/statuscol.nvim",
		event = { "BufReadPost", "BufNewFile" },
		opts = function()
			local statuscol_builtin = require("statuscol.builtin")
			return {
				relculright = true,
				segments = {
					{ text = { statuscol_builtin.foldfunc }, click = "v:lua.ScFa" },
					{ text = { " " } },
					-- IMPORTANT: reserve space for signcolumn explicitly
					{ text = { "%s" }, click = "v:lua.ScSa" },
					-- IMPORTANT: force fixed width for line numbers
					{ text = { statuscol_builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
				},
			}
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
		opts = function()
			local ufo = require("ufo")

			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99 -- Using ufo provider need a large value
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.o.signcolumn = "yes"

			vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
			vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })

			return {
				provider_selector = function(_, filetype, _)
					local exclude_filetypes = { "help", "lazy", "undotree", "nvimtree", "dashboard", "oil" }
					for i = 1, #exclude_filetypes do
						if exclude_filetypes[i] == filetype then
							return ""
						end
					end

					return { "treesitter", "indent" }
				end,
			}
		end,
	},
}
