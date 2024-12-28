local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
-- local workspace_saver = require("wezterm_workspace_saver")

-- wezterm.on("save_state", function(window) workspace_saver.save_state(window) end)
-- wezterm.on("load_state", function() workspace_saver.load_state() end)
-- wezterm.on("restore_state", function(window) workspace_saver.restore_state(window) end)

wezterm.on('toggle-opacity', function(window, pane)
    local overrides = window:get_config_overrides() or {}
    if not overrides.window_background_opacity then
      overrides.window_background_opacity = 0.90
    else
      overrides.window_background_opacity = nil
    end
    window:set_config_overrides(overrides)
  end)

wezterm.on('center-window', function(window, pane)
  window:set_position(570, 240)
  window:set_inner_size(812, 511)
end)

wezterm.on('gui-startup', function(cmd) -- set startup Window position
  local screens = wezterm.gui.screens()

  if screens.virtual_width > 1920 then
      local tab, pane, window = mux.spawn_window(
        {position={x=2480,y=240}}
      )
  else
      local tab, pane, window = mux.spawn_window(
        {position={x=560,y=240}}
      )
  end
end)

-- Functions
local get_last_folder_segment = function(cwd)
    if cwd == nil then
        return "N/A" -- or some default value you prefer
    end

    -- Strip off 'file:///' if present
    local pathStripped = cwd:match("^file:///(.+)") or cwd
    -- Normalize backslashes to slashes for Windows paths
    pathStripped = pathStripped:gsub("\\", "/")
    -- Split the path by '/'
    local path = {}
    for segment in string.gmatch(pathStripped, "[^/]+") do
        table.insert(path, segment)
    end
    return path[#path] -- returns the last segment
end

local function get_current_working_dir(tab)
    local current_dir = tab.active_pane.current_working_dir or ''
    return get_last_folder_segment(current_dir)
end

local process_icons = {
    ['docker'] = wezterm.nerdfonts.linux_docker,
    ['docker-compose'] = wezterm.nerdfonts.linux_docker,
    ['psql'] = wezterm.nerdfonts.dev_postgresql,
    ['kuberlr'] = wezterm.nerdfonts.linux_docker,
    ['kubectl'] = wezterm.nerdfonts.linux_docker,
    ['stern'] = wezterm.nerdfonts.linux_docker,
    ['nvim'] = wezterm.nerdfonts.custom_vim,
    ['make'] = wezterm.nerdfonts.seti_makefile,
    ['vim'] = wezterm.nerdfonts.dev_vim,
    ['go'] = wezterm.nerdfonts.seti_go,
    ['zsh'] = wezterm.nerdfonts.dev_terminal,
    ['bash'] = wezterm.nerdfonts.cod_terminal_bash,
    ['btm'] = wezterm.nerdfonts.mdi_chart_donut_variant,
    ['htop'] = wezterm.nerdfonts.mdi_chart_donut_variant,
    ['cargo'] = wezterm.nerdfonts.dev_rust,
    ['sudo'] = wezterm.nerdfonts.fa_hashtag,
    ['lazydocker'] = wezterm.nerdfonts.linux_docker,
    ['git'] = wezterm.nerdfonts.dev_git,
    ['lua'] = wezterm.nerdfonts.seti_lua,
    ['wget'] = wezterm.nerdfonts.mdi_arrow_down_box,
    ['curl'] = wezterm.nerdfonts.mdi_flattr,
    ['gh'] = wezterm.nerdfonts.dev_github_badge,
    ['ruby'] = wezterm.nerdfonts.cod_ruby,
    ['pwsh'] = wezterm.nerdfonts.seti_powershell,
    ['node'] = wezterm.nerdfonts.dev_nodejs_small,
    ['dotnet'] = wezterm.nerdfonts.md_language_csharp
}
local function get_process(tab)
    local process_name = tab.active_pane.foreground_process_name:match("([^/\\]+)%.exe$") or
                             tab.active_pane.foreground_process_name:match("([^/\\]+)$")

    -- local icon = process_icons[process_name] or string.format('[%s]', process_name)
    local icon = process_icons[process_name] or wezterm.nerdfonts.seti_checkbox_unchecked

    return icon
end

local function basename(s)
    return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

-- This table will hold the configuration.
local config = {}

config.initial_rows = 24
config.initial_cols = 80

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Shell
config.default_prog =
    {"C:\\Users\\shuen\\AppData\\Local\\Microsoft\\WindowsApps\\Microsoft.PowerShell_8wekyb3d8bbwe\\pwsh.exe", '-NoLogo'}

-- Colorscheme
config.color_scheme = "Catppuccin Mocha"
-- config.colors ={
--     background = "#181825"
-- }

-- Window Frame
config.window_frame = {
  border_left_width = '1px',
  border_right_width = '1px',
  border_bottom_height = '1px',
  border_top_height = '1px',
  border_left_color = '#cba6f7',
  border_right_color = '#cba6f7',
  border_bottom_color = '#cba6f7',
  border_top_color = '#cba6f7',
}

-- Background
-- config.window_background_opacity = 0.90

-- Font
config.font = wezterm.font_with_fallback {"FiraCode Nerd Font"}
config.font_size = 10.0

-- Window
-- this is disabled so that 
config.window_decorations = "RESIZE" -- removes close, minimize and so on
config.window_close_confirmation = "AlwaysPrompt"
config.window_padding = {
    top = 5,
    right = 5,
    bottom = 0,
    left = 5
}

-- General
config.scrollback_lines = 3000

-- Tab/Status Bar
-- disables the 'modern' look of the tab bar
config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.status_update_interval = 1000
config.tab_max_width = 60
config.tab_bar_at_bottom = false
-- wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
--   local has_unseen_output = false
--   local is_zoomed = false

--   for _, pane in ipairs(tab.panes) do
--     if not tab.is_active and pane.has_unseen_output then
--       has_unseen_output = true
--     end
--     if pane.is_zoomed then
--       is_zoomed = true
--     end
--   end

--   local cwd = get_current_working_dir(tab)
--   local process = get_process(tab)
--   local zoom_icon = is_zoomed and wezterm.nerdfonts.cod_zoom_in or ""
--   local title = string.format(' %s ~ %s %s ', process, cwd, zoom_icon) -- Add placeholder for zoom_icon

--   return title
-- end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    -- prefer title that was set via `tab:set_title()` or `wezterm cli set-tab-title`
    local title = tab.tab_title ~= "" and tab.tab_title or tab.active_pane.title
    local cwd = tab.active_pane.current_working_dir
    local icon

    if cwd and (title == "pwsh.exe" or title == "wezterm" or title:find("\\")) then
        local pwdBasefolder = cwd.file_path:gsub("^.*/(.*)/$", "%1")
        title = pwdBasefolder
        icon = wezterm.nerdfonts.cod_folder
    elseif title:find("^docs") then
        icon = wezterm.nerdfonts.cod_file
    else
        icon = wezterm.nerdfonts.oct_command_palette
    end

    -- local active_pane_index
    -- for _, pane in ipairs(tab.panes) do
    --   if pane.is_active then
    --     active_pane_index = pane.pane_index + 1
    --     break  -- Stop the loop once the active pane is found
    --   end
    -- end

    -- if active_pane_index == nil then
    --   active_pane_index = 1
    -- elseif #panes == 1 then
    --   return (" %s "):format(tab.tab_index + 1)
    -- end

    -- return (" %s: [%d/%d] "):format(tab.tab_index + 1, active_pane_index, #panes)
    return ("   %s   "):format(tab.tab_index + 1)
end)

wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
    local zoomed = ''
    if tab.active_pane.is_zoomed then
        zoomed = '[Z] '
    end

    local index = ''
    if #tabs > 1 then
        index = string.format('[ %d / %d ] ', tab.tab_index + 1, #tabs)
    end

    return zoomed .. index
end)

-- wezterm.on("update-right-status", function(window, pane)
--   local workspace_or_leader = window:active_workspace()
--   -- Change the worspace name status if leader is active
--   if window:active_key_table() then workspace_or_leader = window:active_key_table() end
--   if window:leader_is_active() then workspace_or_leader = "LEADER" end

--   local cwd = pane:get_current_working_dir() or "N/A"
--   local last_folder = get_last_folder_segment(cwd)
--   local cmd = get_last_folder_segment(pane:get_foreground_process_name())
--   local time = wezterm.strftime("%H:%M")
--   local hostname = " " .. wezterm.hostname() .. " ";

--   window:set_right_status(wezterm.format({
--     { Text = wezterm.nerdfonts.oct_table .. " " .. workspace_or_leader },
--     { Text = " | " },
--     -- { Text = wezterm.nerdfonts.md_folder .. " " .. last_folder },
--     -- { Text = " | " },
--     { Foreground = { Color = "FFB86C" } },
--     { Text = wezterm.nerdfonts.fa_code .. " " .. cmd },
--     "ResetAttributes",
--     { Text = " | " },
--     { Text = wezterm.nerdfonts.oct_person .. " " .. hostname },
--     { Text = " | " },
--     { Text = wezterm.nerdfonts.md_clock .. " " .. time },
--     { Text = " | " },
--   }))
-- end)

-- Panes
config.inactive_pane_hsb = {
    -- saturation = 0.4,
    brightness = 0.6
}

-- Keys
config.leader = {
    key = "Space",
    mods = "CTRL",
    timeout_milliseconds = 3000
}
-- config.keys = {
--   { key = "c", mods = "LEADER", action = act.ActivateCopyMode },

--   -- Pane Keybindings
--   { key = "+", mods = "LEADER", action = act.SplitVertical { domain = "CurrentPaneDomain" } },
--   { key = "|", mods = "LEADER", action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
--   { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
--   { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
--   { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
--   { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
--   { key = "x", mods = "LEADER", action = act.CloseCurrentPane { confirm = true } },
--   { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
--   { key = "s", mods = "LEADER", action = act.RotatePanes "Clockwise" },
--   -- We could make separate keybindings for resizing panes
--   -- But Wezterm offers a custom mode we will use here
--   { key = "r", mods = "LEADER", action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },

--   -- Tab Keybindings
--   { key = "c", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
--   { key = "n", mods = "LEADER", action = act.ActivateTabRelative(1) },
--   { key = "p", mods = "LEADER", action = act.ActivateTabRelative(-1) },
--   { key = "t", mods = "LEADER", action = act.ShowTabNavigator },
--   -- Table for moving tabs around
--   { key = "m", mods = "LEADER", action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },

--   -- Workspace
--   { key = "w", mods = "LEADER", action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
--   {
--     key = 'W',
--     mods = 'LEADER',
--     action = act.PromptInputLine {
--       description = wezterm.format {
--         { Attribute = { Intensity = 'Bold' } },
--         { Foreground = { AnsiColor = 'Fuchsia' } },
--         { Text = 'Enter name for new workspace' },
--       },
--       action = wezterm.action_callback(function(window, pane, line)
--         -- line will be `nil` if they hit escape without entering anything
--         -- An empty string if they just hit enter
--         -- Or the actual line of text they wrote
--         if line then
--           window:perform_action(
--             act.SwitchToWorkspace {
--               name = line,
--             },
--             pane
--           )
--         end
--       end),
--     },
--   },

--   -- Experimental section for workspace saving
--   { key = "S", mods = "LEADER", action = wezterm.action({ EmitEvent = "save_state" }) },
--   { key = "R", mods = "LEADER", action = wezterm.action({ EmitEvent = "restore_state" }) },
--   { key = "L", mods = "LEADER", action = wezterm.action({ EmitEvent = "load_state" }) },
-- }
config.keys = { -- This will create a new split and run the `top` program inside it
    {
        key = "v",
        mods = "LEADER",
        action = act.SplitPane {
            direction = "Right",
            -- command = { args = { "top" } },
            size = {
                Percent = 50
            }
        }
    }, {
        key = "s",
        mods = "LEADER",
        action = act.SplitPane {
            direction = "Down",
            -- command = { args = { "top" } },
            size = {
                Percent = 50
            }
        }
    }, {
        key = "h",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Left")
    }, {
        key = "j",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Down")
    }, {
        key = "k",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Up")
    }, {
        key = "l",
        mods = "LEADER",
        action = act.ActivatePaneDirection("Right")
    }, {
        key = "x",
        mods = "LEADER",
        action = act.CloseCurrentPane {
            confirm = true
        }
    }, {
        key = 'h',
        mods = 'CTRL|ALT',
        action = act.AdjustPaneSize {'Left', 1}
    }, {
        key = 'j',
        mods = 'CTRL|ALT',
        action = act.AdjustPaneSize {'Down', 1}
    }, {
        key = 'k',
        mods = 'CTRL|ALT',
        action = act.AdjustPaneSize {'Up', 1}
    }, {
        key = 'l',
        mods = 'CTRL|ALT',
        action = act.AdjustPaneSize {'Right', 1}
    }, {
        key = 'k',
        mods = 'CTRL|SHIFT',
        action = act.ScrollByPage(-0.5)
    }, {
        key = 'j',
        mods = 'CTRL|SHIFT',
        action = act.ScrollByPage(0.5)
    }, {
        key = 'n',
        mods = 'CTRL|SHIFT',
        action = act.EmitEvent('gui-startup')
    }, {
        key = 'h',
        mods = 'CTRL|SHIFT',
        action = act.Hide
    }, {
        key = 'B',
        mods = 'CTRL|SHIFT',
        action = act.EmitEvent('toggle-opacity'),
    },{
        key = 'd',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ShowDebugOverlay
    },{
      key = 'o',
      mods = 'CTRL|SHIFT',
      action = act.EmitEvent('center-window')
  }
}

config.key_tables = {
    search_mode = {{
        key = 'Enter',
        mods = 'NONE',
        action = act.CopyMode 'PriorMatch'
    }, {
        key = 'Escape',
        mods = 'NONE',
        action = act.CopyMode 'Close'
    }, {
        key = 'n',
        mods = 'CTRL',
        action = act.CopyMode 'NextMatch'
    }, {
        key = 'n',
        mods = 'CTRL|SHIFT',
        action = act.CopyMode 'PriorMatch'
    }}
}

-- Quick tab movement
-- for i = 1, 9 do
--   table.insert(config.keys, {
--     key = tostring(i),
--     mods = "LEADER",
--     action = act.ActivateTab(i - 1)
--   })
-- end

-- config.key_tables = {
--   resize_pane = {
--     { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
--     { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
--     { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
--     { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
--     { key = "Escape", action = "PopKeyTable" },
--     { key = "Enter",  action = "PopKeyTable" },
--   },
--   move_tab = {
--     { key = "h",      action = act.MoveTabRelative(-1) },
--     { key = "j",      action = act.MoveTabRelative(-1) },
--     { key = "k",      action = act.MoveTabRelative(1) },
--     { key = "l",      action = act.MoveTabRelative(1) },
--     { key = "Escape", action = "PopKeyTable" },
--     { key = "Enter",  action = "PopKeyTable" },
--   }
-- }

return config
