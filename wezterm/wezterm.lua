local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
-- local workspace_saver = require("wezterm_workspace_saver")

-- wezterm.on("save_state", function(window) workspace_saver.save_state(window) end)
-- wezterm.on("load_state", function() workspace_saver.load_state() end)
-- wezterm.on("restore_state", function(window) workspace_saver.restore_state(window) end)

wezterm.on("toggle-opacity", function(window, _)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.90
		overrides.colors = {
			tab_bar = {
				background = "1e1e2ee5",
			},
		}
	else
		overrides.window_background_opacity = nil
		overrides.colors = {
			tab_bar = {
				background = "1e1e2e",
			},
		}
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("gui-startup", function(cmd)
	-- safely extract cwd and env
	local cwd = cmd and cmd.cwd or nil
	local env = cmd and cmd.set_environment_variables or nil

	local win_width_cells = 80
	local win_height_cells = 25

	-- spawn mux window
	local _, _, mux_window = mux.spawn_window({
		-- position = position,
		cwd = cwd,
		set_environment_variables = env,
		width = win_width_cells,
		height = win_height_cells,
	})

	-- get window dimensions in pixels
	local window = mux_window:gui_window()
	local dims = window:get_dimensions()
	local pixel_width = dims.pixel_width
	local pixel_height = dims.pixel_height

	-- get screen info
	local screen = wezterm.gui.screens().active
	local new_position = {
		x = math.floor((screen.width - pixel_width) / 2),
		y = math.floor((screen.height - pixel_height) / 2) - 35,
	}

	-- move window to center
	window:set_position(new_position.x, new_position.y)
end)

-- This table will hold the configuration.
local config = {}

config.initial_cols = 25
config.initial_rows = 80

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Shell
config.default_prog = {
	"C:\\Users\\shuen\\AppData\\Local\\Microsoft\\WindowsApps\\Microsoft.PowerShell_8wekyb3d8bbwe\\pwsh.exe",
	"-NoLogo",
}

-- Colorscheme
config.color_scheme = "Catppuccin Mocha"
local catppuccin_colors = {
	rosewater = "#f5e0dc",
	flamingo = "#f2cdcd",
	pink = "#f5c2e7",
	mauve = "#cba6f7",
	red = "#f38ba8",
	maroon = "#eba0ac",
	peach = "#fab387",
	yellow = "#f9e2af",
	green = "#a6e3a1",
	teal = "#94e2d5",
	sky = "#89dceb",
	sapphire = "#74c7ec",
	blue = "#89b4fa",
	lavender = "#b4befe",
	text = "#cdd6f4",
	subtext1 = "#bac2de",
	subtext0 = "#a6adc8",
	overlay2 = "#9399b2",
	overlay1 = "#7f849c",
	overlay0 = "#6c7086",
	surface2 = "#585b70",
	surface1 = "#45475a",
	surface0 = "#313244",
	base = "#1e1e2e",
	mantle = "#181825",
	crust = "#11111b",
}

-- Window Frame
-- config.window_frame = {
--   border_left_width = '1px',
--   border_right_width = '1px',
--   border_bottom_height = '1px',
--   border_top_height = '1px',
--   border_left_color = catppuccin_colors[9],
--   border_right_color = catppuccin_colors[9],
--   border_bottom_color = catppuccin_colors[9],
--   border_top_color = catppuccin_colors[9],
-- }

-- Background
-- config.window_background_opacity = 0.90
config.max_fps = 120

-- Font
config.font = wezterm.font_with_fallback({ "FiraCode Nerd Font" })
config.font_size = 10.0

-- Window
config.window_decorations = "RESIZE" -- removes close, minimize and so on
config.window_close_confirmation = "AlwaysPrompt"
config.window_padding = {
	top = 5,
	right = 5,
	bottom = 0,
	left = 5,
}

-- General
config.scrollback_lines = 3000

-- Tab/Status Bar
-- disables the 'modern' look of the tab bar
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = true
config.hide_tab_bar_if_only_one_tab = true
config.status_update_interval = 1000
config.tab_max_width = 60
config.tab_bar_at_bottom = false

local tab_bar_bg = catppuccin_colors.base
config.colors = {
	tab_bar = {
		background = tab_bar_bg,
	},
}

local tab_min_width = 11
local function basename(s)
	local result = string.gsub(s, "(.*[/\\])(.*)", "%2")
	-- local result = string.gsub(s, "(.*[/\\])(.*)", "")
	return result
end

local function tab_title(tab)
	-- local title = tab_info.tab_title
	local title = tab.active_pane.title

	-- Try to get the current foreground process name
	local process_name = tab.active_pane.foreground_process_name
	if process_name then
		title = process_name
	end

	title = basename(title)

	if title and #title > 0 then
		return title
	end

	return basename(tab.tab_title)
end

local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
wezterm.on("format-tab-title", function(tab, tabs, _, _, _, _)
	local color = catppuccin_colors.blue

	local title = tab_title(tab)
	local title_len = string.len(title)
	local bg = color
	local fg = catppuccin_colors.base
	local right_arrow_bg = tab_bar_bg
	local right_arrow_fg = color
	local left_arrow_bg = tab_bar_bg
	local left_arrow_fg = color
	if not tab.is_active then
		bg = catppuccin_colors.base
		fg = catppuccin_colors.text
		right_arrow_fg = catppuccin_colors.base
		left_arrow_fg = catppuccin_colors.base

		if title_len > 10 then
			title = string.sub(title, 1, tab_min_width - 3) .. "..."
		end
	end

	if title_len < tab_min_width then
		title = title .. string.rep(" ", tab_min_width - title_len)
	end

	local next_tab = tabs[tab.tab_index + 2]

	if next_tab == nil then
		right_arrow_bg = tab_bar_bg
	end

	local prev_tab = tabs[tab.tab_index]
	if prev_tab == nil then
		left_arrow_bg = catppuccin_colors.base
		if tab.is_active then
			left_arrow_bg = color
		end
	end

	return {
		{ Background = { Color = left_arrow_bg } },
		{ Foreground = { Color = left_arrow_fg } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		-- { Text = " [" .. tab.tab_index + 1 .. "] " .. title .. " " },
		{ Text = " " .. title .. " " },
		{ Background = { Color = right_arrow_bg } },
		{ Foreground = { Color = right_arrow_fg } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

wezterm.on("update-right-status", function(window, _)
	local color = catppuccin_colors.blue

	local bg = color
	local fg = catppuccin_colors.base
	local left_arrow_bg = tab_bar_bg
	local left_arrow_fg = color
	local date = wezterm.strftime("%a %_d/%b")
	local time = wezterm.strftime("%I:%M%p")
	local dir_bg = catppuccin_colors.surface0
	local dir_fg = catppuccin_colors.blue

	window:set_right_status(wezterm.format({
		{ Background = { Color = left_arrow_bg } },
		{ Foreground = { Color = dir_bg } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = dir_bg } },
		{ Foreground = { Color = dir_fg } },
		{ Text = " " .. date .. " " },

		{ Background = { Color = dir_bg } },
		{ Foreground = { Color = left_arrow_fg } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = bg } },
		{ Foreground = { Color = fg } },
		{ Text = " " .. time .. " " },
	}))
end)

-- Panes
config.inactive_pane_hsb = {
	-- saturation = 0.4,
	brightness = 0.7,
}

local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "ALT" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "ALT" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 1 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

local function scroll(direction, key)
	return {
		key = key,
		mods = "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if pane:is_alt_screen_active() then
				-- pass the keys to running screen
				win:perform_action({
					SendKey = { key = key, mods = "CTRL" },
				}, pane)
			else
				win:perform_action({ ScrollByPage = direction }, pane)
			end
		end),
	}
end

local show_tab_bar = true
wezterm.on("toggle-tab-bar", function(window, _)
	show_tab_bar = not show_tab_bar

	window:set_config_overrides({
		hide_tab_bar_if_only_one_tab = not show_tab_bar,
		enable_tab_bar = show_tab_bar,
	})
end)

config.warn_about_missing_glyphs = false

-- Keys
config.leader = {
	key = "Space",
	mods = "CTRL",
	timeout_milliseconds = 3000,
}

config.keys = { -- This will create a new split and run the `top` program inside it
	{
		key = "}",
		mods = "CTRL|SHIFT",
		action = act.ActivateTabRelative(1),
	},
	{
		key = "{",
		mods = "CTRL|SHIFT",
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "v",
		mods = "LEADER",
		action = act.SplitPane({
			direction = "Right",
			size = {
				Percent = 50,
			},
		}),
	},
	{
		key = "s",
		mods = "LEADER",
		action = act.SplitPane({
			direction = "Down",
			size = {
				Percent = 50,
			},
		}),
	},
	{
		key = "0",
		mods = "LEADER",
		action = act.PaneSelect({
			mode = "SwapWithActiveKeepFocus",
			alphabet = "1234567890",
		}),
	},
	-- move between split panes
	split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	-- resize panes
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
	{
		key = "x",
		mods = "LEADER",
		action = act.CloseCurrentPane({
			confirm = true,
		}),
	},
	scroll(-0.5, "u"),
	scroll(0.5, "d"),
	scroll(-1, "b"),
	scroll(1, "f"),
	{
		key = "n",
		mods = "LEADER",
		action = act.SpawnTab("DefaultDomain"),
	},
	{
		key = "B",
		mods = "CTRL|SHIFT",
		action = act.EmitEvent("toggle-opacity"),
	},
	{
		key = "0",
		mods = "CTRL",
		action = act.PaneSelect({
			mode = "SwapWithActiveKeepFocus",
			alphabet = "1234567890",
		}),
	},
	{
		key = "T",
		mods = "CTRL|SHIFT",
		action = act.EmitEvent("toggle-tab-bar"),
	},
	-- Disable Ctrl+Tab
	{
		key = "Tab",
		mods = "CTRL",
		action = act.DisableDefaultAssignment,
	},
	-- Disable Ctrl+Shift+Tab
	{
		key = "Tab",
		mods = "CTRL|SHIFT",
		action = act.DisableDefaultAssignment,
	},
}

config.key_tables = {
	search_mode = {
		{
			key = "Enter",
			mods = "NONE",
			action = act.CopyMode("PriorMatch"),
		},
		{
			key = "Escape",
			mods = "NONE",
			action = act.CopyMode("Close"),
		},
		{
			key = "n",
			mods = "CTRL",
			action = act.CopyMode("NextMatch"),
		},
		{
			key = "n",
			mods = "CTRL|SHIFT",
			action = act.CopyMode("PriorMatch"),
		},
	},
}

return config
