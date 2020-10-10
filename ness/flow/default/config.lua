
local awful = require("awful")
local gears = require("gears")

return {
	
	-------------------------------------------
	-- GENERAL
	-------------------------------------------
	
	-- * Terminal emulator to use
	terminal = "xterm",
	
	-- * Text editor to use
	editor = os.getenv("EDITOR") or "nano",
	
	-- * Command to open text editor via the terminal, first argument is `terminal` and the second is `editor`
	editor_command = "%s -e %s",
	
	
	
	-------------------------------------------
	-- CLIENT
	-------------------------------------------
	
	-- * Automatically focus clients under the mouse
	sloppy_focus = false,
	
	-- Follow clients when moving them between tags
	follow_clients = false,
	
	-- TODO: Whether to enable client borders when only one is present on the tag
	-- single_client_border = false,
	
	
	
	-------------------------------------------
	-- SCREEN
	-------------------------------------------
	
	-- * Screen and their contents definition, including tag, wallpaper and client rules customization
	screens = {
		
		-- Index or first matching character's of the head's XRandR name, `*` can be used as a default for unidentified screens
		["*"] = {
			
			-- TODO: Path to wallpaper for this screen
			-- wallpaper = "",
			
			-- Awful taglist filter, possible keys: `all`, `noempty`, `selected`, defaults to `all` if not set
			tag_filter = awful.widget.taglist.filter.all,
			
			-- Amount of tags, can be `nil` to use count specified by the highest defined index in `tags` or 9 if nothing is set
			tag_count = 9,
			
			-- Whether to use focus applications opened using tag's `spawn` logic, `false` by default if `nil`
			spawn_focus = false,
			
			-- Whether to raise applications opened using tag's `spawn` logic, `true` by default if `nil`
			spawn_raise = false,
			
			-- List of tags for this screen
			tags = {
				
				-- Tag index and it's properties, can also include keys from `awful.tag.add`, `screen`, `layout` and `selected` are added automatically 
				[1] = {
					
					-- String name for this tag or `nil` to use it's index
					name = nil,
					
					-- TODO: Bind actuator for this tag or `nil` to use it's index
					-- actuator = nil,
					
					-- Path to icon for this tag (example `awful.tag` property)
					icon = nil,
					
					-- Whether to focus applications managed using the `spawn` logic, `nil` to use this screen's `spawn_focus` key
					spawn_focus = nil,
					
					-- Whether to raise applications opened using the `spawn` logic, `nil` to use this screen's `spawn_raise` key
					spawn_raise = nil,
					
					-- Case-insensitive class name of the applications to spawn on this tag
					spawn = {
						-- "Firefox", "Thunar", "Bottleg"
					},
					
				},
				
			}, -- [tags]
			
		}, -- [*]
		
	}, -- [screens]
	
	
	
	-------------------------------------------
	-- LAYOUT
	-------------------------------------------
	
	-- * List of available layouts to pick from
	allowed_layouts = {
		awful.layout.suit.tile,
		awful.layout.suit.tile.left,
		awful.layout.suit.tile.bottom,
		awful.layout.suit.tile.top,
		awful.layout.suit.fair,
		awful.layout.suit.fair.horizontal,
		awful.layout.suit.spiral,
		awful.layout.suit.spiral.dwindle,
		awful.layout.suit.max,
		awful.layout.suit.max.fullscreen,
		awful.layout.suit.magnifier,
		awful.layout.suit.corner.nw,
		awful.layout.suit.corner.ne,
		-- awful.layout.suit.corner.sw,
		-- awful.layout.suit.corner.se,
		-- awful.layout.suit.floating,
	},
	
	
	
	-------------------------------------------
	-- BIND
	-------------------------------------------
	
	-- * Default modifier to use in case `combo_modifier` is given in the bind's `combo` parameter
	default_modifier = "Mod4",
	
	-- Combo keyword that should be replaced with the `default_modifier`
	combo_modifier = "Mod",
	
	-- Symbol used to concatenate combo keys
	combo_separator = "+",
	
	-- Whether to convert key combos based on the KEY enum (allows usage of simplified key names, ie. VolumeUp)
	combo_convert = true,
	
	-- * Include app specific keybinds in the keybind widget (doesn't functionally affect the hotkeys)
	app_hotkeys = true,
	
	-- List of possible modifiers, `false` values will also override the default `awful` ignores
	allowed_modifiers = {
		["Any"]		= true,
		["Mod1"]	= true,
		["Mod3"]	= true,
		["Mod4"]	= true,
		["Shift"]	= true,
		["Control"]	= true,
		
		["Mod2"]	= false,
		["Lock"]	= false,
	},
	
}
