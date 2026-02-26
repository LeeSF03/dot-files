local root_markers1 = {
	".emmyrc.json",
	".luarc.json",
	".luarc.jsonc",
}
local root_markers2 = {
	".luacheckrc",
	".stylua.toml",
	"stylua.toml",
	"selene.toml",
	"selene.yml",
}

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers1, root_markers2, { ".git" } }
		or vim.list_extend(vim.list_extend(root_markers1, root_markers2), { ".git" }),
	settings = {
		Lua = {
			runtime = {
				-- Specify LuaJIT for Neovim
				version = "LuaJIT",
				-- Include Neovim runtime files
				path = vim.split(package.path, ";"),
			},
			diagnostics = {
				-- Recognize `vim` as a global
				globals = { "vim" },
				disable = { "trailing-space" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
		hint = {
			enable = true,
			arrayIndex = "Enable",
			await = true,
			paramName = "All",
			paramType = true,
			semicolon = "Disable",
			setType = true,
		},
		telemetry = {
			enable = false,
		},
	},
})
vim.lsp.enable("lua_ls")
