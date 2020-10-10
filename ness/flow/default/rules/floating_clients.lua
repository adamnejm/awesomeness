
-- Default AwesomeWM rules for the floating clients

local rules = require("ness/lib/rules")

-------------------------------------------

rules.add {
	rule_any = {
		instance = {
			"DTA",
			"copyq",
			"pinentry",
		},
		
		class = {
			"Arandr",
			"Blueman-manager",
			"Gpick",
			"Kruler",
			"MessageWin",
			"Sxiv",
			"Tor Browser",
			"Wpa_gui",
			"veromix",
			"xtightvncviewer",
		},
		
		name = {
			"Event Tester",
		},
		
		role = {
			"AlarmWindow",
			"ConfigManager",
			"pop-up",
		}
	},
	
	properties = {
		floating = true,
	},
}
