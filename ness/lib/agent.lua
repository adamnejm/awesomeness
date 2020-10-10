
local config	= require("config", true)
local util		= require("ness/lib/util")
local awful		= require("awful")
local beautiful	= require("beautiful")

-- Handles various client-related stuff, like spawn management or titlebars 
local agent = {}



-------------------------------------------
-- SPAWN
-------------------------------------------

-- TODO: Generate a lookup table instead!
--- Manages on which tag the client will spawn
--- Additionally it can move your focus to that tag and raise the client based on the configuration
-- @param c Client object to control
function agent.manageSpawnTag(c)
	local scr = c.screen
	local scr_cfg = scr.cfg
	local scr_cfg_tags = scr_cfg.tags
	
	if not scr_cfg_tags then return end

	
	-- Check if client is allowed to be on the tag it spawned (for when clients are added to two or more tags)
	if c.first_tag then
		local tag_cfg = scr_cfg_tags[c.first_tag.index]
		if tag_cfg and tag_cfg.spawn and util.table.hasValue(tag_cfg.spawn, c.class, true) then
			
			if util.getFirstDefined(tag_cfg.spawn_focus, scr_cfg.spawn_focus, false) then
				c.first_tag:view_only()
			end
			
			if util.getFirstDefined(tag_cfg.spawn_raise, scr_cfg.spawn_raise, true) then
				c:raise()
			end
			
			return
		end
	end
	
	-- If client spawned on other tag than it's allowed on, move it to first valid tag
	for id, tag_cfg in pairs(scr_cfg_tags) do
		if tag_cfg.spawn and util.table.hasValue(tag_cfg.spawn, c.class, true) then
			
			local tag = scr.tags[id]
			if tag then
				
				c:move_to_tag(tag)
				
				if util.getFirstDefined(tag_cfg.spawn_focus, scr_cfg.spawn_focus, false) then
					tag:view_only()
				end
				
				if util.getFirstDefined(tag_cfg.spawn_raise, scr_cfg.spawn_raise, true) then
					c:raise()
				end
				
				return
			end
			
		end
	end
end

--- Retrieves unreachable clients and resets their position
-- @param c Client to check
function agent.makeReachable(c)
	if not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end
end



-------------------------------------------
-- MANAGEMENT
-------------------------------------------

function agent.sloppyFocus(c)
	if config.sloppy_focus then
		c:emit_signal("request::activate", "mouse_enter", { raise = false })
	end
end



-------------------------------------------
-- BORDER
-------------------------------------------

--- Set border color based on the `border_focus` theme entry
function agent.setBorderFocused(c)
	c.border_color = beautiful.border_focus
end

--- Set border color based on the `border_normal` theme entry
function agent.setBorderNormal(c)
	c.border_color = beautiful.border_normal
end





return agent


