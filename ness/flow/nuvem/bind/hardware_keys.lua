
-- Some nice hardware buttons

local bind = require("ness/lib/bind")
local awful = require("awful")

-------------------------------------------

bind.globalKeys {
	["Hardware"] = {
		{
			combo	= "VolumeUp",
			desc	= "Change volume",
			press	= function(c)
				os.execute("pactl set-sink-volume 0 +5%")
				os.execute("pactl set-sink-volume 1 +5%")
			end,
		},{
			combo	= "VolumeDown",
			desc	= "Change volume",
			press	= function(c)
				os.execute("pactl set-sink-volume 0 -5%")
				os.execute("pactl set-sink-volume 1 -5%")
			end,
		},
	},
}
