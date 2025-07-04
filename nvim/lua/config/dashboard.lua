local dashboard = require("dashboard")

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

local logo_narrow = [[
        ██████                           ████████████ ████████████
       ██████                           ████████████████  ████
       ████        ████████████████ ███████████ ████
      ████         ███     ███       ███████    ████████████
     ████        ███████████████████████████  ████
   ██████  ███ ███     ███    █████████████████
  ████████████████████████████████████████████████
]]

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

local selected_logo = logo_narrow

local function pad_logo(logo)
	local padded_lines = {}
	local max_len = 0

	for line in logo:gmatch("[^\n]+") do
		local width = vim.fn.strdisplaywidth(line)

		-- If new max_len found, re-pad previous lines
		if width > max_len then
			for i, l in ipairs(padded_lines) do
				padded_lines[i] = l .. string.rep(" ", width - max_len)
			end
			max_len = width
		end

		-- If shorter, pad current line
		local padded = line .. string.rep(" ", max_len - width)
		table.insert(padded_lines, padded)
	end

	table.insert(padded_lines, "")
	table.insert(padded_lines, "")

	return padded_lines
end

local opts = {
	theme = "doom",
	hide = {
		-- this is taken care of by lualine
		-- enabling this messes up the actual laststatus setting after loading a file
		statusline = true,
		winbar = true,
	},
	config = {
		header = pad_logo(selected_logo),
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

-- Attempt to redraw the dashboard on resize
-- vim.api.nvim_create_autocmd("VimResized", {
--   callback = function()
--     local new_logo = logo_narrow
--     if vim.o.columns > 137 then new_logo = logo_wide end
--
--     local formatted_logo = string.rep("\n", 1) .. new_logo .. "\n\n"
--     opts.config.header = vim.split(formatted_logo, "\n")
--
--     dashboard.setup(opts)
--     print("there should be a new logo")
--     vim.cmd("Dashboard")
--   end,
-- })

vim.api.nvim_set_hl(0, "DashboardHeader", { fg = "#b4befe" })
vim.api.nvim_set_hl(0, "DashboardDesc", { fg = "#cba6f7" })
vim.api.nvim_set_hl(0, "DashboardIcon", { fg = "#f5c2e7" })
vim.api.nvim_set_hl(0, "DashboardKey", { fg = "#f5c2e7" })
vim.api.nvim_set_hl(0, "DashboardFooter", { fg = "#f9e2af" })

dashboard.setup(opts)
