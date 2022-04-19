local wezterm = require("wezterm")
return {
	font = wezterm.font("CaskaydiaCove Nerd Font Mono"),
	-- color_scheme = "Batman",
	default_prog = { "wsl.exe" },
	-- window_background_image = "/mnt/d/Wallpaper/hentai/sexy-asian-stockings-girl-boobs-underwear-thong-fantasy-tanned-heels-bra-sa-ae4.jpg",

	window_background_image = "D:\\Wallpaper\\hentai\\img (4)f.jpg",

	-- window_background_image = "D:\\Wallpaper\\project\\do_nothing.png", -- meme
	-- window_background_opacity = 0.95,
	-- text_background_opacity = 0.4,
	window_background_image_hsb = {
		brightness = 0.012,
		hue = 1.0,
		saturation = 1.0,
	},
	colors = {
		cursor_bg = "#F5F5F5",
		-- cursor_fg = "black",
	},
	launch_menu = {
		-- {
		-- 	args = { "top" },
		-- },
		{
			-- Optional label to show in the launcher. If omitted, a label
			-- is derived from the `args`
			label = "powershell",
			-- The argument array to spawn.  If omitted the default program
			-- will be used as described in the documentation above
			args = { "powershell" },

			-- You can specify an alternative current working directory;
			-- if you don't specify one then a default based on the OSC 7
			-- escape sequence will be used (see the Shell Integration
			-- docs), falling back to the home directory.
			cwd = "D:\\Learn-React-II\\my-react-app",

			-- You can override environment variables just for this command
			-- by setting this here.  It has the same semantics as the main
			-- set_environment_variables configuration option described above
			-- set_environment_variables = { FOO = "bar" },
		},
	},
	keys = {
		{ key = "i", mods = "CTRL", action = { SendKey = { key = "F7", mods = "CTRL" } } },
	},
}
