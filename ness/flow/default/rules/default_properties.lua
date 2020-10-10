
-- Default AwesomeWM properties for ruleset matching all clients

local rules = require("ness/lib/rules")
local awful = require("awful")
local beautiful = require("beautiful")

-------------------------------------------

rules.setDefaultProperties {
	border_width	= beautiful.border_width,
	border_color	= beautiful.border_normal,
	focus			= awful.client.focus.filter,
	raise			= true,
	screen			= awful.screen.preferred,
	placement		= awful.placement.no_overlap + awful.placement.no_offscreen
}
