
-- Default AwesomeWM client buttons

local bind = require("ness/lib/bind")
local awful = require("awful")

-------------------------------------------

bind.clientButtons {
	{
		combo	= "MouseLeft",
		desc	= "Focus",
		press	= function(c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
		end,
	},{
		combo	= "Mod + MouseLeft",
		desc	= "Move",
		press	= function(c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
			awful.mouse.client.move(c)
		end,
	},{
		combo	= "Mod + MouseRight",
		desc	= "Resize",
		press	= function(c)
			c:emit_signal("request::activate", "mouse_click", { raise = true })
			awful.mouse.client.resize(c)
		end,
	},
}
