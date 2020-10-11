
local awful = require("awful")
local gears = require("gears")

return {
	
	-------------------------------------------
	-- GENERAL
	-------------------------------------------
	
	terminal		= "termite",
	editor			= os.getenv("EDITOR") or "nano",
	editor_command	= "%s -e %s",
	
	
	
	-------------------------------------------
	-- CLIENT
	-------------------------------------------
	
	follow_clients	= true,
	
	
	
	-------------------------------------------
	-- SCREEN
	-------------------------------------------
	
	screens = {
		["*"] = {
			tag_filter = awful.widget.taglist.filter.noempty,
			tag_count = 8,
			tags = {
				[5] = {
					name = "Q",
					actuator = "Q",
				},
				[6] = {
					name = "W",
					actuator = "W",
				},
				[7] = {
					name = "E",
					actuator = "E",
				},
				[8] = {
					name = "R",
					actuator = "R",
				}
			}
		},
	},
	
	
	
	-------------------------------------------
	-- LAYOUT
	-------------------------------------------
	
	allowed_layouts = {
		awful.layout.suit.tile,
		awful.layout.suit.max,
		-- awful.layout.suit.max.fullscreen,
		-- awful.layout.suit.magnifier,
		-- awful.layout.suit.floating,
	},
	
	
	
	-------------------------------------------
	-- BIND
	-------------------------------------------
	
	default_modifier	= "Mod4",
	
	combo_modifier		= "Mod",
	combo_separator		= "+",
	combo_convert		= true,
	app_hotkeys			= false,
	
	allowed_modifiers = {
		["Any"]		= true,
		["Mod1"]	= true,
		["Mod3"]	= true,
		["Mod4"]	= true,
		["Shift"]	= true,
		["Control"]	= true,
		
		["Mod2"]	= false,
		["Lock"]	= false,
	},
	
}
