
-- Default AwesomeWM global keys

local config = require("config", true)
local bind = require("ness/lib/bind")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

-------------------------------------------

return function(mainmenu, menubar)

	bind.globalKeys {
		["Awesome"] = {
			{
				combo	= "Mod + S",
				desc	= "Keybinds",
				press	= hotkeys_popup.show_help,
			},{
				combo	= "Mod + W",
				desc	= "Menu",
				press	= function()
					mainmenu:show()
				end,
			},{
				combo	= "Mod + Control + R",
				desc	= "Reload",
				press	= awesome.restart,
			},{
				combo	= "Mod + Shift + Q",
				desc	= "Quit",
				press	= awesome.quit,
			},
		},
		
		["Launcher"] = {
			{
				combo	= "Mod + Return",
				desc	= "Terminal",
				press	= function()
					awful.spawn(config.terminal)
				end,
			},{
				combo	= "Mod + R",
				desc	= "Run prompt",
				press	= function()
					awful.screen.focused().prompt:run()
				end,
			},{
				combo	= "Mod + X",
				desc	= "Execute Lua",
				press	= function()
					awful.prompt.run {
						prompt			= "Run Lua code: ",
						textbox			= awful.screen.focused().prompt.widget,
						exe_callback	= awful.util.eval,
						history_path	= awful.util.get_cache_dir() .. "/history_eval",
					}
				end,
			},{
				combo	= "Mod + P",
				desc	= "Menubar",
				press	= function()
					menubar.show()
				end,
			},
		},
		
		["Tag"] = {
			{
				combo	= "Mod + Left",
				desc	= "Previous tag",
				press	= awful.tag.viewprev,
			},{
				combo	= "Mod + Right",
				desc	= "Next tag",
				press	= awful.tag.viewnext,
			},{
				combo	= "Mod + Escape",
				desc	= "Last tag",
				press	= awful.tag.history.restore,
			},
		},
		
		["Layout"] = {
			{
				combo	= "Mod + H",
				desc	= "Increase master width",
				press	= function()
					awful.tag.incmwfact(0.05)
				end,
			},{
				combo	= "Mod + L",
				desc	= "Decrease master width",
				press	= function()
					awful.tag.incmwfact(-0.05)
				end,
			},{
				combo	= "Mod + Shift + H",
				desc	= "Increase masters count",
				press	= function()
					awful.tag.incnmaster(1, nil, true)
				end,
			},{
				combo	= "Mod + Shift + L",
				desc	= "Decrease masters count",
				press	= function()
					awful.tag.incnmaster(-1, nil, true)
				end,
			},{
				combo	= "Mod + Control + H",
				desc	= "Increase columns count",
				press	= function()
					awful.tag.incncol(1, nil, true)
				end,
			},{
				combo	= "Mod + Control + L",
				desc	= "Decrease columns count",
				press	= function()
					awful.tag.incncol(-1, nil, true)
				end,
			},{
				combo	= "Mod + Space",
				desc	= "Next layout",
				press	= function()
					awful.layout.inc(1)
				end,
			},{
				combo	= "Mod + Shift + Space",
				desc	= "Previous layout",
				press	= function()
					awful.layout.inc(-1)
				end,
			},
		},
		
		["Screen"] = {
			{
				combo	= "Mod + Control + J",
				desc	= "Switch to next screen",
				press	= function()
					awful.screen.focus_relative(1)
				end,
			},{
				combo	= "Mod + Control + K",
				desc	= "Switch to previous screen",
				press	= function()
					awful.screen.focus_relative(-1)
				end,
			},
		},
		
		["Client"] = {
			{
				combo	= "Mod + J",
				desc	= "Focus next client",
				press	= function()
					awful.client.focus.byidx(1)
				end,
			},{
				combo	= "Mod + K",
				desc	= "Focus previous client",
				press	= function()
					awful.client.focus.byidx(-1)
				end,
			},{
				combo	= "Mod + Shift + J",
				desc	= "Move client up the tree",
				press	= function()
					awful.client.swap.byidx(1)
				end,
			},{
				combo	= "Mod + Shift + K",
				desc	= "Move client down the tree",
				press	= function()
					awful.client.swap.byidx(-1)
				end,
			},{
				combo	= "Mod + U",
				desc	= "Jump to urgent client",
				press	= function()
					awful.client.urgent.jumpto()
				end,
			},{
				combo	= "Mod + Tab",
				desc	= "Go back",
				press	= function()
					awful.client.focus.history.previous()
					if client.focus then
						client.focus:raise()
					end
				end,
			},{
				combo	= "Mod + Control + N",
				desc	= "Unminimize",
				press	= function()
					local c = awful.client.restore()
					if c then
						c:emit_signal("request::activate", "key.unminimize", { raise = true })
					end
				end,
			},
		},
		
	}
	
end
