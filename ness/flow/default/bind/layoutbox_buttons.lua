
-- Default AwesomeWM buttons for the layoutbox widget

local bind = require("ness/lib/bind")
local awful = require("awful")

-------------------------------------------

local function nextLayout()
	awful.layout.inc(1)
end

local function previousLayout()
	awful.layout.inc(-1)
end

-------------------------------------------

return bind.getButtons {
	{
		combo	= "MouseLeft",
		desc	= "Next layout",
		press	= nextLayout,
	},{
		combo	= "MouseRight",
		desc	= "Previous layout",
		press	= previousLayout,
	},{
		combo	= "ScrollUp",
		desc	= "Next layout",
		press	= nextLayout,
	},{
		combo	= "ScrollDown",
		desc	= "Previous Layout",
		press	= previousLayout,
	},
}
