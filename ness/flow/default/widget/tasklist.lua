
-- Default Awesome tasklist widget

local awful = require("awful")

-------------------------------------------

local tasklist_buttons = require("bind/tasklist_buttons")

return function(scr)
	
	return awful.widget.tasklist {
		screen	= scr,
		buttons	= tasklist_buttons,
		filter	= awful.widget.tasklist.filter.currenttags,
	}
	
end
