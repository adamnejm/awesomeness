
-- Default AwesomeWM client keys

local bind = require("ness/lib/bind")
local awful = require("awful")

-------------------------------------------

bind.clientKeys {
	{
		combo	= "Mod + F",
		desc	= "Fullscreen",
		press	= function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
	},{
		combo	= "Mod + Shift + C",
		desc	= "Kill",
		press	= function(c)
			c:kill()
		end,
	},{
		combo	= "Mod + Control + Space",
		desc	= "Floating mode",
		press	= function(c)
			awful.client.floating.toggle(c)
		end,
	},{
		combo	= "Mod + Return",
		desc	= "Move to master node",
		press	= function(c)
			c:swap(awful.client.getmaster())
		end,
	},{
		combo	= "Mod + O",
		desc	= "Move to next screen",
		press	= function(c)
			c:move_to_screen()
		end,
	},{
		combo	= "Mod + T",
		desc	= "Keep on top",
		press	= function(c)
			c.ontop = not c.ontop
		end,
	},{
		combo	= "Mod + N",
		desc	= "Minimize",
		press	= function(c)
			c.minimized = true
		end,
	},{
		combo	= "Mod + M",
		desc	= "Maximize",
		press	= function(c)
			c.maximized = not c.maximized
			c:raise()
		end,
	},{
		combo	= "Mod + Control + M",
		desc	= "Maximize vertically",
		press	= function(c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end,
	},{
		combo	= "Mod + Shift + M",
		desc	= "Maximize horizontally",
		press	= function(c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end,
	},
}
