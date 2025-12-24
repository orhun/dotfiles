local wezterm = require("wezterm")

local config = wezterm.config_builder()
-- config.colors = {
-- 	background = "#1d1c2d",
-- 	foreground = "#fff",
-- }
-- config.color_scheme = "Gruvbox dark, pale (base16)"
config.color_scheme = "Gruvbox dark, pale (base16)"
config.enable_tab_bar = false

config.font = wezterm.font("JetBrains Mono")
config.font_size = 25.0

local schemes = {
	"Catppuccin Latte",
	"Gruvbox dark, pale (base16)",
}
local current_scheme = 1

wezterm.on("toggle-theme", function(window, pane)
	current_scheme = current_scheme % #schemes + 1
	local scheme = schemes[current_scheme]

	-- play flashbang sound
	wezterm.run_child_process({
		"mpv",
		"--really-quiet",
		"--no-video",
		"/home/orhun/audio/flashbang.mp3",
	})

	if scheme == "Gruvbox dark, pale (base16)" then
		window:set_config_overrides({
			color_scheme = scheme,
			colors = {
				background = "#1d1c2d",
				foreground = "#ffffff",
			},
		})
	else
		window:set_config_overrides({
			color_scheme = scheme,
			colors = nil,
		})
	end
end)

config.keys = {
	{
		key = "0",
		mods = "CTRL",
		action = wezterm.action.ResetFontSize,
	},
	{
		key = "t",
		mods = "CTRL",
		action = wezterm.action.EmitEvent("toggle-theme"),
	},
}

return config
