
-- Default AwesomeWM buttons for the taglist widget

local bind = require("ness/lib/bind")
local awful = require("awful")

-------------------------------------------

return bind.getButtons {
	{
		combo	= "MouseLeft",
		desc	= "Focus tag",
		press	= function(tag)
			tag:view_only()
		end,
	},{
		combo	= "Mod + MouseLeft",
		desc	= "Move client to tag",
		press	= function(tag)
			if client.focus then
				client.focus:move_to_tag(tag)
			end
		end,
	},{
		combo	= "MouseRight",
		desc	= "Toggle tag",
		press	= awful.tag.viewtoggle,
	},{
		combo	= "Mod + MouseRight",
		desc	= "Toggle client's tag",
		press	= function(tag)
			if client.focus then
				client.focus:toggle_tag(tag)
			end
		end,
	},{
		combo	= "ScrollUp",
		desc	= "Next tag",
		press	= function(tag)
			awful.tag.viewnext(tag.screen)
		end,
	},{
		combo	= "ScrollDown",
		desc	= "Previous tag",
		press	= function(tag)
			awful.tag.viewprev(tag.screen)
		end,
	},
}
