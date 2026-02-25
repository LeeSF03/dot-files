return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
		"luukvbaal/statuscol.nvim",
	},
	config = function()
		local ufo = require("ufo")
		local statuscol = require("statuscol")
		local statuscol_builtin = require("statuscol.builtin")

		vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
		vim.o.foldcolumn = "1"
		vim.o.foldlevel = 99 -- Using ufo provider need a large value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		vim.o.signcolumn = "yes"

		vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
		vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })

		local exclude_filetypes = { "help", "lazy", "undotree", "nvimtree", "dashboard", "oil" }

		ufo.setup({
			provider_selector = function(_, filetype, _)
				for i = 1, #exclude_filetypes do
					if exclude_filetypes[i] == filetype then
						return ""
					end
				end

				return { "treesitter", "indent" }
			end,
		})

		statuscol.setup({
			relculright = true,
			segments = {
				{ text = { statuscol_builtin.foldfunc }, click = "v:lua.ScFa" },
				{ text = { " " } },

				-- IMPORTANT: reserve space for signcolumn explicitly
				{ text = { "%s" }, click = "v:lua.ScSa" },

				-- IMPORTANT: force fixed width for line numbers
				{
					text = { statuscol_builtin.lnumfunc, " " },
					condition = { true },
					click = "v:lua.ScLa",
				},
			},
		})
	end,
	event = {
		"VeryLazy",
	},
}
