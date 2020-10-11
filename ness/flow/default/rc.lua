
----------------------------------------------------------
--                                                      --
--  A ███▙   ████  ██████████  ██████████  ██████████   --
--  W ████▙  ████  ██████████  ██████████  ██████████   --
--  E █████▙ ████  ████        ████        ████         --
--  S ██████▙████  ███████     ██████████  ██████████   --
--  O ████▜██████  ███████     ██████████  ██████████   --
--  M ████ ▜█████  ████              ████        ████   --
--  E ████  ▜████  ██████████  ██████████  ██████████   --
--  / ████   ▜███  ██████████  ██████████  ██████████   --
--                                            	        --
----------------------------------------------------------
--                                                      --
-- Instead of editing this file, why not create a Flow? --
-- Learn how to do that here:                           --
-- https://github.com/adamnejm/awesomeness              --
--                                                      --
----------------------------------------------------------



-------------------------------------------
-- LIBRARIES
-------------------------------------------


pcall(require, "luarocks.loader")

-- Awesome libraries
local gears		= require("gears")				-- Utility stuff
local awful		= require("awful")				-- General purpose
local wibox		= require("wibox")				-- Widgets, drawables and such
local beautiful	= require("beautiful")			-- Theme library

require("awful.autofocus")

-- Awesome/Ness libraries
local util		= require("ness/lib/util")		-- Provides utility functions
local bind		= require("ness/lib/bind")		-- Easier way to create keys and buttons
local agent		= require("ness/lib/agent")		-- Responsible for client management
local rules		= require("ness/lib/rules")		-- Client rules with some extra functionality
local flower	= require("ness/lib/flower")	-- Controls the Flow system and themes
local tagger	= require("ness/lib/tagger")	-- Takes care of identifying screens and creating tags
local notify	= require("ness/lib/notify")	-- Pretty useless notification library
local marshal	= require("ness/lib/marshal")	-- Configuration and compatibility expert



-------------------------------------------
-- SETUP
-------------------------------------------

-- Include the config that's set to imitate the stock Awesome experience
local config = require("config")

-- Overriding keys is as usual
-- config.terminal = "termite"
-- config.default_modifier = "Mod1"

-- Merging config recursively is also possible
-- marshal.merge {
-- 	screens = {
-- 		["*"] = {
-- 			tags = {
-- 				[1] = {
-- 					name = "First!"
-- 				}
-- 			}
-- 		}
-- 	}
-- }

-- Editing some of the `config` variables (ie. `allowed_modifiers`) might require you to call that again
marshal.applyConfiguration()

-- Set Awesome variables like the global `terminal` or `modkey` to increase compatibility
marshal.applyCompatibility()

-- Theme initialization can also be handled by the `flower` library
flower.setTheme("default")



-------------------------------------------
-- SCREEN
-------------------------------------------

-- Screen independent widgets
local menubar		= require("widget/menubar")
local systray		= require("widget/systray")
local textclock		= require("widget/textclock")
local mainmenu		= require("widget/mainmenu")
local launcher		= require("widget/launcher")(mainmenu)

-- Handle all current and future screens
awful.screen.connect_for_each_screen(function(scr)
	
	-- Identify the screen and attach it's configuration
	tagger.setupScreenConfig(scr)
	
	-- Create tags for this screen
	tagger.createTags(scr)
	
	-- Let `bind` library handle all of the tag binds
	bind.generateTagKeys(scr)
	
	-- Screen's widgets
	scr.prompt		= require("widget/prompt")()
	scr.wibar		= require("widget/wibar")(scr)
	scr.taglist		= require("widget/taglist")(scr)
	scr.tasklist	= require("widget/tasklist")(scr)
	scr.layoutbox	= require("widget/layoutbox")(scr)
	
	-- Wibar setup
	scr.wibar:setup {
		{
			launcher,
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
require("rules/titlebars")



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

client.connect_signal("mouse::enter", function(c)
	agent.sloppyFocus(c)
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

-- Borrow the following modules from a Flow called `nuvem`
-- require("bind/hardware_keys", "nuvem")
-- require("bind/client_binds", "nuvem")



-------------------------------------------
-- ERROR
-------------------------------------------

-- Startup errors are handled by Awesome, but we can take care of runtime errors
awesome.connect_signal("debug::error", function(err)
	notify.runtimeError(err)
end)
