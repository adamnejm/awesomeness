
-- Default AwesomeWM buttons for the tasklist widget

local bind = require("ness/lib/bind")
local awful = require("awful")

-------------------------------------------

return bind.getButtons {
	{
		combo	= "MouseLeft",
		desc	= "(Un)minimize client",
		press	= function(c)
			if c == client.focus then
				c.minimized = true
			else
				c:emit_signal("request::activate", "tasklist", { raise = true })
			end
		end,
	},{
		combo	= "MouseRight",
		desc	= "Client list",
		press	= function()
			awful.menu.client_list()
		end,
	},{
		combo	= "ScrollUp",
		desc	= "Next client",
		press	= function()
			awful.client.focus.byidx(1)
		end,
	},{
		combo	= "ScrollDown",
		desc	= "Previous client",
		press	= function()
			awful.client.focus.byidx(-1)
		end,
	},
}
