local header = {
	"        ██████                           ████████████ ████████████  ",
	"       ██████                           ████████████████  ████  ",
	"       ████        ████████████████ ███████████ ████           ",
	"      ████         ███     ███       ███████    ████████████    ",
	"     ████        ███████████████████████████  ████             ",
	"   ██████  ███ ███     ███    █████████████████             ",
	"  ████████████████████████████████████████████████              ",
	"                                                                          ",
	"                                                                          ",
}
local key_format = "  %s"

return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "doom",
			hide = {
				-- this is taken care of by lualine
				-- enabling this messes up the actual laststatus setting after loading a file
				statusline = true,
				winbar = true,
			},
			config = {
				header = header,
				center = {
          -- stylua: ignore start
          {
            action = "Telescope find_files",
            desc = " Find File                                 ",
            icon = " ", key = "f", key_format = key_format
          },
          {
            action = ":ene",
            desc = " New File                                  ",
            icon = " ", key = "n", key_format = key_format
          },
          {
            action = "Telescope live_grep",
            desc = " Find Text                                 ",
            icon = " ", key = "g", key_format = key_format
          },
          {
            action = ":e C:\\Users\\shuen\\.config\\nvim\\lua\\config\\lsp\\init.lua",
            desc = " Language Server File                      ",
            icon = " ", key = "s", key_format = key_format
          },
          {
            action = "checkhealth",
            desc = " Check Health                              ",
            icon = " ", key = "h", key_format = key_format
          },
          {
            action = "Lazy",
            desc = " Lazy                                      ",
            icon = "󰒲 ", key = "l", key_format = key_format
          },
          { 
            action = function() vim.api.nvim_input("<CMD>qa<CR>") end,
            desc = " Quit                                      ",
            icon = " ", key = "q", key_format = key_format
          },
					-- stylua: ignore end
				},
				footer = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					return {
						"",
						"󱐋 Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
					}
				end,
				vertical_center = true,
			},
			layout = {
				{ type = "header" },
				{ type = "padding", val = 9 },
				{ type = "center" },
				{ type = "padding", val = 1 },
				{ type = "footer" },
			},
		})

		-- open dashboard when lazy is closed after downlaoding plugins
		if vim.o.filetype == "lazy" then
			vim.api.nvim_create_autocmd("WinClosed", {
				pattern = tostring(vim.api.nvim_get_current_win()),
				once = true,
				callback = function()
					vim.schedule(function()
						vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
					end)
				end,
			})
		end
		vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#b4befe" })
		vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#cba6f7" })
		vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#f5c2e7" })
		vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#f5c2e7" })
		vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#f9e2af" })
	end,
}
