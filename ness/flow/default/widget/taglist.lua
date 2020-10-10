
-- Default AwesomeMW taglist widget + `filter` key from config

local awful = require("awful")

-------------------------------------------

local taglist_buttons = require("bind/taglist_buttons")

return function(scr)
	
	return awful.widget.taglist {
		screen	= scr,
		buttons	= taglist_buttons,
		filter	= scr.cfg.tag_filter or awful.widget.taglist.filter.all,
	}
	
end
