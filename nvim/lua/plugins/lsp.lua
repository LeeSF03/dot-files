return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "LspInfo", "LspInstall", "LspUninstall" },
		config = function()
			require("config.lsp")
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = { "MasonInstall", "MasonUninstall", "MasonUpdate", "Mason", "MasonLog" },
		opts = { ui = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } } },
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		cmd = {
			"MasonToolsInstall",
			"MasonToolsInstallSync",
			"MasonToolsUpdate",
			"MasonToolsUpdateSync",
			"MasonToolsClean",
		},
		opts = {
			-- list of tools(linters, formatters, etc):
			-- https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
			-- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
			ensure_installed = {
				-- js, ts, jsx, tsx
				-- use bun installed instead for faster executable
				"prettier",
				"prettierd",
				"eslint_d",

				-- python
				"ruff",

				-- golang
				"golangci-lint",
				"gofumpt",
				"golines",

				-- lua
				"stylua",
			},
		},
	},
	{
		"giuxtaposition/blink-cmp-copilot",
		dependencies = { "zbirenbaum/copilot.lua", "saghen/blink.cmp" },
		event = { "InsertEnter" },
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		build = "cargo build --release",
		event = { "InsertEnter", "CmdlineEnter" },
		opts_extend = { "sources.default" },
		config = function()
			require("blink.cmp").setup({
				fuzzy = { implementation = "prefer_rust_with_warning" },
				keymap = {
					["<C-s>"] = { "show", "show_documentation", "hide_documentation" },
					["<C-e>"] = { "hide" },
					["<C-y>"] = { "select_and_accept" },

					["<C-u>"] = { "scroll_documentation_up", "fallback" },
					["<C-d>"] = { "scroll_documentation_down", "fallback" },
				},
				completion = {
					menu = {
						border = "rounded",
						draw = {
							align_to = "label",
							columns = {
								{ "kind_icon", gap = 1 },
								{ "label", "label_description", gap = 1 },
								{ "source_id" },
							},
							components = {
								label_description = { width = { max = 30 } },
								label = { width = { max = 30 } },
							},
						},
					},
					documentation = {
						window = { border = "rounded" },
						auto_show = true,
						auto_show_delay_ms = 500,
					},
				},
				cmdline = {
					enabled = true,
					completion = { menu = { auto_show = true } },
				},
				signature = {
					enabled = true,
					window = { border = "rounded" },
				},
				sources = {
					default = { "lsp", "path", "snippets", "buffer", "copilot", "markdown" },
					per_filetype = {
						markdown = { "markdown", "snippets", "buffer", "copilot" },
					},
					providers = {
						copilot = {
							name = "copilot",
							module = "blink-cmp-copilot",
							score_offset = 100,
							async = true,
							transform_items = function(_, items)
								local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
								local kind_idx = #CompletionItemKind + 1
								CompletionItemKind[kind_idx] = "Copilot"
								for _, item in ipairs(items) do
									item.kind = kind_idx
								end
								return items
							end,
						},
						markdown = {
							name = "RenderMarkdown",
							module = "render-markdown.integ.blink",
							fallbacks = { "lsp" },
						},
					},
				},
				appearance = {
					use_nvim_cmp_as_default = true,
					nerd_font_variant = "mono",
					kind_icons = {
						Copilot = "",
						Text = "󰉿",
						Method = "󰊕",
						Function = "󰊕",
						Constructor = "󰒓",

						Field = "󰜢",
						Variable = "󰆦",
						Property = "󰖷",

						Class = "󱡠",
						Interface = "󱡠",
						Struct = "󱡠",
						Module = "󰅩",

						Unit = "󰪚",
						Value = "󰦨",
						Enum = "󰦨",
						EnumMember = "󰦨",

						Keyword = "󰻾",
						Constant = "󰏿",

						Snippet = "󱄽",
						Color = "󰏘",
						File = "󰈔",
						Reference = "󰬲",
						Folder = "󰉋",
						Event = "󱐋",
						Operator = "󰪚",
						TypeParameter = "󰬛",
					},
				},
			})
			vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#1e1e2e" })
			vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
			vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#f38ba8" })
			vim.api.nvim_set_hl(0, "BlinkCmpDoc", { bg = "#1e1e2e" })
			vim.api.nvim_set_hl(0, "BlinkCmpSignatureHelpBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
			vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#89b4fa", bg = "#1e1e2e" })
		end,
	},
	{
		"nvimdev/lspsaga.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
			"rachartier/tiny-code-action.nvim",
		},
		event = "LspAttach",
		config = function()
			local telescope_builtin = require("telescope.builtin")

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					local lspsaga = require("lspsaga")
					lspsaga.setup({
						code_action = { keys = { quit = "q", exec = "<CR>" } },
						definition = { keys = { quit = "q" } },
						rename = { keys = { quit = "<ESC>", exec = "<CR>" }, in_select = false },
					})

          -- diagnostics
          -- stylua: ignore start
          vim.keymap.set("n", "gsc", "<CMD>Lspsaga show_cursor_diagnostics<CR>",    { desc = "Show cursor diagnostics",     buffer = ev.buf })
          vim.keymap.set("n", "gss", "<CMD>Lspsaga show_line_diagnostics<CR>",      { desc = "Show line diagnostics",       buffer = ev.buf })
          vim.keymap.set("n", "gsb", "<CMD>Lspsaga show_buf_diagnostics<CR>",       { desc = "Show buffer diagnostics",     buffer = ev.buf })
          vim.keymap.set("n", "gsw", "<CMD>Lspsaga show_workspace_diagnostics<CR>", { desc = "Show workplace diagnostics",  buffer = ev.buf })
          vim.keymap.set("n", "gsN", "<CMD>Lspsaga diagnostic_jump_prev<CR>",       { desc = "Jump to previous diagnostic", buffer = ev.buf })
          vim.keymap.set("n", "gsn", "<CMD>Lspsaga diagnostic_jump_next<CR>",       { desc = "Jump to next diagnostic",     buffer = ev.buf })

          -- disable default lsp keymaps
          pcall(vim.keymap.del, "n", "grn")
          pcall(vim.keymap.del, "n", "gra")
          pcall(vim.keymap.del, "n", "grr")
          pcall(vim.keymap.del, "n", "gri")

          -- lsp finder and definition
          vim.keymap.set("n", "gp",         "<CMD>Lspsaga peek_definition<CR>", { desc = "Peek defenition",   buffer = ev.buf })
          vim.keymap.set("n", "gd",         "<CMD>Lspsaga goto_definition<CR>", { desc = "Go to defenition",  buffer = ev.buf })
          vim.keymap.set("n", "gD",         vim.lsp.buf.declaration,            { desc = "Go to declaration", buffer = ev.buf })
          vim.keymap.set("n", "<leader>gr", telescope_builtin.lsp_references,   { desc = "Search references", buffer = ev.buf })
          vim.keymap.set("n", "<leader>rn", "<CMD>Lspsaga rename<CR>",          { desc = "Rename variable",   buffer = ev.buf })

          -- code action and format
          vim.keymap.set("n", "<leader>ca", function() require("tiny-code-action").code_action() end, { desc ="Code Action",  buffer = ev.buf })
          vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end,      { desc = "Code Format", buffer = ev.buf })
					-- stylua: ignore end
				end,
			})
		end,
	},
}
