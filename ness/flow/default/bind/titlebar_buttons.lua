
-- Default AwesomeWM buttons for titlebars

local bind = require("ness/lib/bind")
local awful = require("awful")

-------------------------------------------

return function(c)
	
	return bind.getButtons {
		{
			combo	= "MouseLeft",
			desc	= "Move client",
			press	= function()
				c:emit_signal("request::activate", "titlebar", { raise	= true })
				awful.mouse.client.move(c)
			end,
		},{
			combo	= "MouseRight",
			desc	= "Resize client",
			press	= function()
				c:emit_signal("request::activate", "titlebar", { raise = true })
				awful.mouse.client.resize(c)
			end,
		}
	}
	
end


