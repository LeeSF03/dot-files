vim.lsp.config("ts_ls", {
	init_options = { hostInfo = "neovim" },
	cmd = { "typescript-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	root_dir = function(bufnr, on_dir)
		-- The project root is where the LSP can be started from
		-- As stated in the documentation above, this LSP supports monorepos and simple projects.
		-- We select then from the project root, which is identified by the presence of a package
		-- manager lock file.
		local root_markers =
			{ "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", "package.json" }
		-- Give the root markers equal priority by wrapping them in a table
		root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
			or vim.list_extend(root_markers, { ".git" })
		-- exclude deno
		-- local deno_path = vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" })
		local project_root = vim.fs.root(bufnr, root_markers)
		-- if deno_path and (not project_root or #deno_path >= #project_root) then
		-- 	return
		-- end
		-- We fallback to the current working directory if no project root is found
		on_dir(project_root or vim.fn.getcwd())
	end,
	handlers = {
		-- handle rename request for certain code actions like extracting functions / types
		["_typescript.rename"] = function(_, result, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			vim.lsp.util.show_document({
				uri = result.textDocument.uri,
				range = {
					start = result.position,
					["end"] = result.position,
				},
			}, client.offset_encoding)
			vim.lsp.buf.rename()
			return vim.NIL
		end,
	},
	commands = {
		["editor.action.showReferences"] = function(command, ctx)
			local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
			local file_uri, position, references = unpack(command.arguments)

			local quickfix_items = vim.lsp.util.locations_to_items(references --[[@as any]], client.offset_encoding)
			vim.fn.setqflist({}, " ", {
				title = command.title,
				items = quickfix_items,
				context = {
					command = command,
					bufnr = ctx.bufnr,
				},
			})

			vim.lsp.util.show_document({
				uri = file_uri --[[@as string]],
				range = {
					start = position --[[@as lsp.Position]],
					["end"] = position --[[@as lsp.Position]],
				},
			}, client.offset_encoding)
			---@diagnostic enable: assign-type-mismatch

			vim.cmd("botright copen")
		end,
	},
	on_attach = function(client, bufnr)
		-- ts_ls provides `source.*` code actions that apply to the whole file. These only appear in
		-- `vim.lsp.buf.code_action()` if specified in `context.only`.
		vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
			local source_actions = vim.tbl_filter(function(action)
				return vim.startswith(action, "source.")
			end, client.server_capabilities.codeActionProvider.codeActionKinds)

			vim.lsp.buf.code_action({
				context = {
					only = source_actions,
					diagnostics = {},
				},
			})
		end, {})
	end,
})
vim.lsp.enable("ts_ls")

vim.lsp.config("cssls", {
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
	root_markers = { "package.json", ".git" },
	settings = {
		css = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		scss = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
		less = {
			validate = true,
			lint = {
				unknownAtRules = "ignore",
			},
		},
	},
})
vim.lsp.enable("cssls")

vim.lsp.config("cssmodules_ls", {
	cmd = { "cssmodules-language-server" },
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
	root_markers = { "package.json" },
})
vim.lsp.enable("cssmodules_ls")

vim.lsp.config("html", {
	cmd = { "vscode-html-language-server", "--stdio" },
	filetypes = { "html", "templ", "svg" },
	root_markers = { "package.json", ".git" },
	settings = {},
	init_options = {
		provideFormatter = true,
		embeddedLanguages = { css = true, javascript = true },
		configurationSection = { "html", "css", "javascript" },
	},
})
vim.lsp.enable("html")
