
-- Additional client keys and buttons

local bind = require("ness/lib/bind")
local awful = require("awful")

-------------------------------------------

bind.clientButtons {
	{
		combo	= "Mod + MouseMiddle",
		desc	= "Kill",
		press	= function(c)
			c:kill()
		end,
	},
}

-------------------------------------------

bind.clientKeys {
	{
		combo	= "Mod + B",
		desc	= "Toggle titlebar",
		press	= function(c)
			awful.titlebar.toggle(c)
		end,
	},
}
