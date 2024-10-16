local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.colors = {
	background = "#171717",
	foreground = "#fff",
}
config.color_scheme = "Gruvbox dark, pale (base16)"
config.enable_tab_bar = false

config.font = wezterm.font("Fira Code")
config.font_size = 15.0

return config
