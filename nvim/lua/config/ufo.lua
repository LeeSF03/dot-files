local ufo = require("ufo")
local statuscol = require("statuscol")
local statuscol_builtin = require("statuscol.builtin")

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })

local exclude_filetypes = { "help", "lazy", "undotree", "nvimtree", "dashboard", "oil" }

ufo.setup({
	provider_selector = function(bufnr, filetype, buftype)
		for i = 1, #exclude_filetypes do
			if exclude_filetypes[i] == filetype then
				return ""
			end
		end

		return { "treesitter", "indent" }
	end,
})

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.foldingRange = {
--     dynamicRegistration = false,
--     lineFoldingOnly = true
-- }
-- local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
-- for _, ls in ipairs(language_servers) do
--     require('lspconfig')[ls].setup({
--         capabilities = capabilities
--         -- you can add other fields for setting up lsp server in this table
--     })
-- end
-- require('ufo').setup()

statuscol.setup({
	relculright = true,
	segments = {
		{ text = { statuscol_builtin.foldfunc }, click = "v:lua.ScFa" },
		{ text = { " " } },
		{ text = { "%s" }, click = "v:lua.ScSa" },
		{ text = { statuscol_builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
	},
})
