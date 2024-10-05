local wezterm = require("wezterm")

local config = wezterm.config_builder()
config.color_scheme = "Kolorit"
config.enable_tab_bar = false
config.font = wezterm.font("Fira Code")
config.font_size = 15.0

return config
