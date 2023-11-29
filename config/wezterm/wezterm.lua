local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- {{{ APPEARANCE
-- window
-- transparency
config.window_background_opacity = 0.90
--config.win32_system_backdrop = "Acrylic"
config.window_decorations = "RESIZE"
-- colorscheme
config.color_scheme = "Tokyo Night Moon"
-- font
config.font = wezterm.font("FiraCode Nerd Font")
config.font = wezterm.font_with_fallback({ "FiraCode Nerd Font", "RobotoMono Nerd Font Mono" })
config.font_size = 15

-- padding : zero margin
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- tab
-- completely tab is removed
-- config.enable_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
-- tab at bottom
config.tab_bar_at_bottom = true

--scroll bar
config.enable_scroll_bar = false
config.min_scroll_bar_height = "0.0cell"
-- }}}
--

--{{{ SYSTEM
-- default change into Ubuntu in WSL,
-- check by ":wsl -l -v" in powershell etc.
-- config.default_domain = "WSL:Ubuntu"
-- config.wsl_domains = {
-- 	{
-- 		name = "WSL:Ubuntu",
-- 		distribution = "Ubuntu",
-- 		default_cwd = "~",
-- 	},
-- }
-- startup with full screen
wezterm.on("gui-startup", function(cmd)
	local args = {}
	if cmd then
		args = cmd.args
	end
	local tab, base_pane, window = mux.spawn_window({
		workspace = "coding",
		args = args,
	})
	window:gui_window():maximize()

	-- this is for ssh
	local pane_name = string.sub(base_pane:get_domain_name(), 1, 3)
	if pane_name == "SSH" then
		return
	end

	local left_pane = base_pane:split({
		-- domain = "DefaultDomain",
		direction = "Right",
		size = 0.35,
		-- args = { "vtop" },
	})
	local clock_pane = left_pane:split({
		-- domain =
		direction = "Bottom",
		size = 0.30,
		-- args = { "tty-clock -C 5 -c" },
	})
	base_pane:send_text("cd ~ ; clear\n")
	left_pane:send_text("cd ~ ; clear ; vtop -t brew\n")
	clock_pane:send_text("cd ~ ; clear ; tty-clock -C 5 -c\n")
	base_pane:activate()
	-- mux.set_active_workspace("coding")
end)

--}}}

-- {{{ KEY MAPPINGS
config.keys = {
	-- Alt(Opt)+Shift+F to toggle fullscreen
	{
		key = "f",
		mods = "SHIFT|META",
		-- action = act.ToggleFullScreen,
		action = act.ToggleFullScreen,
	},
	{
		key = "Z",
		mods = "CTRL",
		action = act.TogglePaneZoomState,
	},
	{
		key = "Enter",
		mods = "CTRL|SHIFT",
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "Enter",
		mods = "CTRL|ALT",
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "q",
		mods = "CTRL",
		action = wezterm.action.QuitApplication,
	},
}
--}}}

return config
