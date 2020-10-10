
-- Default AwesomeMW wibar widget

local awful = require("awful")

-------------------------------------------

return function(scr)
	
	return awful.wibar {
		screen = scr,
		position = "top",
	}
	
end
