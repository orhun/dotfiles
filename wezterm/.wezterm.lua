local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.colors = {
	background = "#151515",
	foreground = "#fff",
}
config.color_scheme = "Gruvbox dark, pale (base16)"
config.enable_tab_bar = false

config.font = wezterm.font("JetBrains Mono")
config.font_size = 25.0

config.keys = {
	{
		key = "0",
		mods = "CTRL",
		action = wezterm.action.ResetFontSize,
	},
}

return config
