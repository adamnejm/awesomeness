
-- Default Awesome layoutbox widget

local awful = require("awful")

-------------------------------------------

local layoutbox_buttons = require("bind/layoutbox_buttons")

return function(scr)
	
	local layoutbox = awful.widget.layoutbox(scr)
	layoutbox:buttons(layoutbox_buttons)
	
	return layoutbox
	
end
