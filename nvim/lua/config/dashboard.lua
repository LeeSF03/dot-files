local dashboard = require("dashboard")
-- stylua: ignore start
-- local logo = [[
--
--
--
--
--
--
--
-- ██╗     ███████╗███████╗ ██████╗███████╗
-- ██║     ██╔════╝██╔════╝██╔════╝██╔════╝
-- ██║     █████╗  █████╗  ╚█████╗ █████╗
-- ██║     ██╔══╝  ██╔══╝   ╚═══██╗██╔══╝
-- ███████╗███████╗███████╗██████╔╝██║
-- ╚══════╝╚══════╝╚══════╝╚═════╝ ╚═╝
-- ]]

local logo_narrow = {
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

-- local logo_narrow = [[
--                ▐▀▄       ▄▀▌   ▄▄▄▄▄▄▄
--                ▌▒▒▀▄▄▄▄▄▀▒▒▐▄▀▀▒██▒██▒▀▀▄
--               ▐▒▒▒▒▀▒▀▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▄
--               ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▒▒▒▒▒▒▒▒▒▒▒▒▀▄
--             ▀█▒▒▒█▌▒▒█▒▒▐█▒▒▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌   ▄▄
--             ▀▌▒▒▒▒▒▒▀▒▀▒▒▒▒▒▒▀▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐ ▄█▒█
--             ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▒█▀
--             ▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█▀
--              ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐
--               ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐
--               ▐▄▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▄▌
--                 ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
--         ██████                           ████████████ ████████████
--        ██████                           ████████████████  ████
--        ████        ████████████████ ███████████ ████
--       ████         ███     ███       ███████    ████████████
--      ████        ███████████████████████████  ████
--    ██████  ███ ███     ███    █████████████████
--   ████████████████████████████████████████████████
-- ]]

-- local logo_narrow = [[
--         ██████                           ████████████ ████████████
--        ██████                           ████████████████  ████
--        ████        ████████████████ ███████████ ████
--       ████         ███     ███       ███████    ████████████
--      ████        ███████████████████████████  ████
--    ██████  ███ ███     ███    █████████████████
--   ████████████████████████████████████████████████
--
-- 
--                                                 
--          ████ ██████           █████      ██
--         ███████████             █████ 
--         █████████ ███████████████████ ███   ███████████
--        █████████  ███    █████████████ █████ ██████████████
--       █████████ ██████████ █████████ █████ █████ ████ █████
--     ███████████ ███    ███ █████████ █████ █████ ████ █████
--    ██████  █████████████████████ ████ █████ █████ ████ ██████
-- ]]
-- stylua: ignore end

local selected_logo = logo_narrow

local opts = {
	theme = "doom",
	hide = {
		-- this is taken care of by lualine
		-- enabling this messes up the actual laststatus setting after loading a file
		statusline = true,
		winbar = true,
	},
	config = {
		header = selected_logo,
		center = {
			{ action = "Telescope find_files", desc = " Find File", icon = " ", key = "f" },
			{ action = ":ene", desc = " New File", icon = " ", key = "n" },
			{ action = "Telescope live_grep", desc = " Find Text", icon = " ", key = "g" },
			{
				action = ":e C:\\Users\\shuen\\.config\\nvim\\lua\\config\\lsp\\init.lua",
				desc = " Language Server File",
				icon = " ",
				key = "s",
			},
			{ action = "checkhealth", desc = " Check Health", icon = " ", key = "h" },
			{ action = "Lazy", desc = " Lazy", icon = "󰒲 ", key = "l" },
			{
				action = function()
					vim.api.nvim_input("<CMD>qa<CR>")
				end,
				desc = " Quit",
				icon = " ",
				key = "q",
			},
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
}

for _, button in ipairs(opts.config.center) do
	button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
	button.key_format = "  %s"
end

-- open dashboard after closing lazy
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

dashboard.setup(opts)
