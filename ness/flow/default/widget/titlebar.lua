
-- Default Awesome titlebar widget and it's sub-widgets 

local awful = require("awful")
local wibox = require("wibox")

-------------------------------------------

return function(c)
	
	local titlebar_buttons = require("bind/titlebar_buttons")(c)
	local titlebar = awful.titlebar(c)
	
	titlebar:setup {
		{
			-- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = titlebar_buttons,
			layout  = wibox.layout.fixed.horizontal
		},
		{
			-- Middle
			{
				align  = "center",
				widget = awful.titlebar.widget.titlewidget(c)
			},
			buttons = titlebar_buttons,
			layout  = wibox.layout.flex.horizontal
		},
		{
			-- Right
			awful.titlebar.widget.floatingbutton (c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton   (c),
			awful.titlebar.widget.ontopbutton    (c),
			awful.titlebar.widget.closebutton    (c),
			layout = wibox.layout.fixed.horizontal()
		},
		layout = wibox.layout.align.horizontal
	}
	
	return titlebar
	
end


