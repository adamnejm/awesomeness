
-- Default AwesomeWM global keys related to tags

local config = require("config")
local bind = require("ness/lib/bind")
local awful = require("awful")

-------------------------------------------

for i = 1, 9 do
	
	bind.globalKeys {
		["Tag"] = {
			{
				combo	= "Mod + #" .. i + 9,
				desc	= "Switch to tag",
				press	= function()
					local screen = awful.screen.focused()
					local tag = screen.tags[i]
					if tag then
						tag:view_only()
					end
				end,
			},{
				combo	= "Mod + Control + #" .. i + 9,
				desc	= "Toggle tag",
				press	= function()
					local screen = awful.screen.focused()
					local tag = screen.tags[i]
					if tag then
						awful.tag.viewtoggle(tag)
					end
				end,
			},{
				combo	= "Mod + Shift + #" .. i + 9,
				desc	= "Move client to tag",
				press	= function()
					if client.focus then
						local tag = client.focus.screen.tags[i]
						if tag then
							client.focus:move_to_tag(tag)
							if config.follow_clients then
								tag:view_only()
							end
						end
					end
				end,
			},{
				combo	= "Mod + Control + Shift + #" .. i + 9,
				desc	= "Merge client to tag",
				press	= function()
					if client.focus then
						local tag = client.focus.screen.tags[i]
						if tag then
							client.focus:toggle_tag(tag)
						end
					end
				end,
			},
		},
	}
	
end
