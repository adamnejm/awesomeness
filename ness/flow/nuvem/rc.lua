
---------------------------------------------------------------------------
--                                                                       --
--  ███▙   ████  ████    ████  ████    ████  ██████████  █████▙  ▟█████  --
--  ████▙  ████  ████    ████  ████    ████  ██████████  ██████▙▟██████  --
--  █████▙ ████  ████    ████  ████    ████  ████        ██████████████  --
--  ██████▙████  ████    ████  ████    ████  ███████     ████ ▜██▛ ████  --
--  ████▜██████  ████    ████  ▜███▙  ▟███▛  ███████     ████  ▜▛  ████  --
--  ████ ▜█████  ████    ████   ▜███▙▟███▛   ████        ████      ████  --
--  ████  ▜████  ████████████    ▜██████▛    ██████████  ████      ████  --
--  ████   ▜███  ████████████     ▜████▛     ██████████  ████      ████  --
--                                            	                         --
---------------------------------------------------------------------------



-------------------------------------------
-- LIBRARIES
-------------------------------------------

local gears		= require("gears")				-- Utility stuff
local awful		= require("awful")				-- General purpose
local wibox		= require("wibox")				-- Widgets, drawables and such

local bind		= require("ness/lib/bind")		-- Easier way to create keys and buttons
local agent		= require("ness/lib/agent")		-- Responsible for client management
local rules		= require("ness/lib/rules")		-- Client rules with some extra functionality
local flower	= require("ness/lib/flower")	-- Controls the Flow system and themes
local tagger	= require("ness/lib/tagger")	-- Takes care of identifying screens and creating tags
local notify	= require("ness/lib/notify")	-- Pretty useless notification library
local marshal	= require("ness/lib/marshal")	-- Configuration and compatibility expert

require("awful.autofocus")



-------------------------------------------
-- SETUP
-------------------------------------------

local config = require("config")
marshal.applyConfiguration()
marshal.applyCompatibility()


flower.setTheme("nuvem")



-------------------------------------------
-- SCREEN
-------------------------------------------

-- Static widgets
local menubar		= require("widget/menubar")
local systray		= require("widget/systray")
local textclock		= require("widget/textclock")
local mainmenu		= require("widget/mainmenu")

awful.screen.connect_for_each_screen(function(scr)
	
	tagger.setupScreenConfig(scr)
	tagger.createTags(scr)
	
	bind.generateTagKeys(scr)
	
	
	-- Screen dependent widgets
	scr.prompt		= require("widget/prompt")()
	scr.wibar		= require("widget/wibar")(scr)
	scr.taglist		= require("widget/taglist")(scr)
	scr.tasklist	= require("widget/tasklist")(scr)
	scr.layoutbox	= require("widget/layoutbox")(scr)
	
	scr.wibar:setup {
		{
			scr.taglist,
			scr.prompt,
			layout = wibox.layout.fixed.horizontal,
		},
		scr.tasklist,
		{
			systray,
			textclock,
			scr.layoutbox,
			layout = wibox.layout.fixed.horizontal,
		},
		layout = wibox.layout.align.horizontal,
	}
	
end)



-------------------------------------------
-- RULES
-------------------------------------------

require("rules/default_properties")
require("rules/floating_clients")



-------------------------------------------
-- CLIENT MANAGEMENT
-------------------------------------------

client.connect_signal("manage", function(c)
	if awesome.startup then
		agent.makeReachable(c)
	else
		agent.manageSpawnTag(c)
	end
end)

client.connect_signal("focus", function(c)
	agent.setBorderFocused(c)
end)

client.connect_signal("unfocus", function(c)
	agent.setBorderNormal(c)
end)

client.connect_signal("request::titlebars", function(c)
	require("widget/titlebar")(c)
end)



-------------------------------------------
-- BIND
-------------------------------------------

require("bind/client_keys")
require("bind/client_buttons")

require("bind/global_buttons")(mainmenu)
require("bind/global_keys")(mainmenu, menubar)

require("bind/hardware_keys")
require("bind/client_binds")



-------------------------------------------
-- ERROR
-------------------------------------------

-- Startup errors are handled by Awesome, but we can take care of runtime errors
awesome.connect_signal("debug::error", function(err)
	notify.runtimeError(err)
end)
