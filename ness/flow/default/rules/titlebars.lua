
-- Default AwesomeWM rules for titlebars

local rules = require("ness/lib/rules")

-------------------------------------------

rules.add {
	rule_any = {
		type = {
			"normal",
			"dialog",
		}
	},
	
	properties = {
		titlebars_enabled = true,
	},
}
