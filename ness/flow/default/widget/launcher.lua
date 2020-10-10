
-- Default AwesomeMW launcher widget

local awful = require("awful")
local beautiful = require("beautiful")

-------------------------------------------

return function(mainmenu)
	
	return awful.widget.launcher {
		menu = mainmenu,
		image = beautiful.awesome_icon,
	}
	
end