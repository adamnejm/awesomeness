
-- Default AwesomeWM global buttons

local bind = require("ness/lib/bind")
local awful = require("awful")

-------------------------------------------

return function(mainmenu)

	bind.globalButtons {
		{
			combo	= "MouseRight",
			desc	= "Open main menu",
			press	= function()
				mainmenu:toggle()
			end,
		},{
			combo	= "ScrollUp",
			desc	= "Next tag",
			press	= awful.tag.viewnext,
		},{
			combo	= "ScrollDown",
			desc	= "Previous tag",
			press	= awful.tag.viewprev,
		}
	}
	
end
