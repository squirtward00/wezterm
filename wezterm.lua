-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- Basic config
config.front_end = "OpenGL"
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"

config.animation_fps = 1
-- config.cursor_blink_rate = 5
config.term = "xterm-256color" -- Set the terminal type

config.font = wezterm.font("JetBrains Mono NL")
config.cell_width = 1
config.prefer_egl = true
config.font_size = 20
-- config.window_background_opacity = 0.9

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- tabs
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false

-- keymaps
config.keys = {
	{
		key = "h",
		mods = "CMD|SHIFT",
		action = act.SplitPane({
			direction = "Right",
			size = { Percent = 50 },
		}),
	},
	{
		key = "v",
		mods = "CMD|SHIFT",
		action = act.SplitPane({
			direction = "Down",
			size = { Percent = 50 },
		}),
	},
	{
		key = 'w',
		mods = 'CMD|SHIFT',
		action = wezterm.action.CloseCurrentPane { confirm = false },
	},
	{
		key = "U",
		mods = "CMD|SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "I",
		mods = "CMD|SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "=",
		mods = "CMD|SHIFT",
		action = act.ToggleFullScreen
	},
	{
		key = "O",
		mods = "CMD|SHIFT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "P",
		mods = "CMD|SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{ key = "9", mods = "OPT", action = act.PaneSelect },
	{ key = "L", mods = "OPT", action = act.ShowDebugOverlay },

	{
		key = 'LeftArrow',
		mods = "CMD",
		action = act.ActivatePaneDirection 'Left' },

    {
		key = 'RightArrow',
		mods = "CMD", action = act.ActivatePaneDirection 'Right' }, { key = 'UpArrow',
		mods = "CMD",
		action = act.ActivatePaneDirection 'Up' },

    {
		key = 'DownArrow',
		mods = "CMD",
		action = act.ActivatePaneDirection 'Down' },
}

-- For example, changing the color scheme:
config.color_scheme = "One"
config.colors = {
	background = "#000000",
	cursor_bg = "#ffffff"
}

config.window_frame = {
	font = wezterm.font({ family = "Iosevka Custom", weight = "Regular" }),
	active_titlebar_bg = "#ffffff",
	-- active_titlebar_bg = "#181616",
}

config.window_decorations = "NONE | RESIZE"
config.initial_cols = 120
config.initial_rows = 30


-- wezterm.on("gui-startup", function(cmd)
-- 	local args = {}
-- 	if cmd then
-- 		args = cmd.args
-- 	end
--
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	-- window:gui_window():maximize()
-- 	-- window:gui_window():set_position(0, 0)
-- end)

-- and finally, return the configuration to wezterm
return config
