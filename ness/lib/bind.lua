
local config	= require("config", true)
local util		= require("ness/lib/util")
local rules		= require("ness/lib/rules")
local awful		= require("awful")
local gears		= require("gears")


-- Less convoluted way to manage keys and buttons
local bind = {}



-------------------------------------------
-- ENUMS
-------------------------------------------

local KEY = {
	["MouseLeft"]		= "1",
	["MouseMiddle"]		= "2",
	["MouseRight"]		= "3",
	["ScrollUp"]		= "4",
	["ScrollDown"]		= "5",
	["ScrollLeft"]		= "6",
	["ScrollRight"]		= "7",
	["MouseForward"]	= "8",
	["MouseBack"]		= "9",
	
	["Space"]			= "space",
	["VolumeUp"]		= "XF86AudioRaiseVolume",
	["VolumeDown"]		= "XF86AudioLowerVolume",
	["Forward"]			= "XF86Forward",
	["Back"]			= "XF86Back",
}

local ascii_set = "qwertyuiopasdfghjklzxcvbnm"
for i = 1, #ascii_set do
	local char = string.sub(ascii_set, i, i)
	KEY[string.upper(char)] = char
end

bind.KEY = KEY



-------------------------------------------
-- IGNORED MODIFIERS
-------------------------------------------

function bind.ignoreAwfulModifiers()
	local ignored_modifiers = {}
	for mod, allowed in pairs(config.allowed_modifiers) do
		if not allowed then
			table.insert(ignored_modifiers, mod)
		end
	end
	
	awful.key.ignore_modifiers = ignored_modifiers
	awful.button.ignore_modifiers = ignored_modifiers
end


-------------------------------------------
-- HELPERS
-------------------------------------------

local function parseCombo(combo)
	local mods, actuator = {}, ""
	
	local exp = util.string.split(combo, config.combo_separator, true)
	for _, key in ipairs(exp) do
		
		if key == config.combo_modifier then
			key = config.default_modifier
		elseif config.combo_convert and KEY[key] then
			key = KEY[key]
		end
		
		if config.allowed_modifiers[key] then
			table.insert(mods, key)
		else
			actuator = key
			break
		end
	end
	
	return mods, actuator
end

local function registerKey(data)
	local mods, actuator = parseCombo(data.combo)
	local key_info = {
		group		= data.group	or "undefined",
		description = data.desc		or "press and see",
	}
	
	return awful.key(mods, actuator, data.press or dummy_func, data.release or key_info, key_info)
end

local function registerButton(data)
	local mods, actuator = parseCombo(data.combo)
	return awful.button(mods, actuator, data.press, data.release)
end



-------------------------------------------
-- KEYS
-------------------------------------------

globalkeys = globalkeys or {}

function bind.globalKey(data)
	local key = registerKey(data)
	
	globalkeys = gears.table.join(globalkeys, key)
	root.keys(globalkeys)
	
	return key
end

function bind.globalKeys(data)
	local new_keys = {}
	for group, keys in pairs(data) do
		for _, key_data in ipairs(keys) do
			key_data.group = key_data.group or group
			table.insert(new_keys, registerKey(key_data))
		end
	end
	
	globalkeys = gears.table.join(globalkeys, table.unpack(new_keys))
	root.keys(globalkeys)
	
	return globalkeys
end

-------------------------------------------

clientkeys = clientkeys or {}

function bind.clientKey(data)
	data.group = data.group or "Client"
	local key = registerKey(data)
	
	clientkeys = gears.table.join(clientkeys, key)
	rules.getDefaultProperties().keys = clientkeys
	awful.rules.rules = awful.rules.rules
	
	return key
end

function bind.clientKeys(data)
	local new_keys = {}
	for _, key_data in ipairs(data) do
		key_data.group = key_data.group or "Client"
		table.insert(new_keys, registerKey(key_data))
	end
	
	clientkeys = gears.table.join(clientkeys, table.unpack(new_keys))
	rules.getDefaultProperties().keys = clientkeys
	return clientkeys
end



-------------------------------------------
-- BUTTONS
-------------------------------------------

globalbuttons = globalbuttons or {}

function bind.globalButton(data)
	local btn = registerButton(data)
	
	globalbuttons = gears.table.join(globalbuttons, btn)
	root.buttons(globalbuttons)
	
	return btn
end

function bind.globalButtons(data)
	local new_btns = {}
	for _, btn_data in ipairs(data) do
		table.insert(new_btns, registerButton(btn_data))
	end
	
	globalbuttons = gears.table.join(globalbuttons, table.unpack(new_btns))
	root.buttons(globalbuttons)
	
	return globalbuttons
end

-------------------------------------------

clientbuttons = clientbuttons or {}

function bind.clientButton(data)
	local btn = registerButton(data)
	
	clientbuttons = gears.table.join(clientbuttons, btn)
	rules.getDefaultProperties().buttons = clientbuttons
	
	return btn
end

function bind.clientButtons(data)
	local new_btns = {}
	for _, btn_data in ipairs(data) do
		table.insert(new_btns, registerButton(btn_data))
	end
	
	clientbuttons = gears.table.join(clientbuttons, table.unpack(new_btns))
	rules.getDefaultProperties().buttons = clientbuttons
	
	return clientbuttons
end

-------------------------------------------

function bind.getButtons(data)
	local new_btns = {}
	for _, btn_data in ipairs(data) do
		table.insert(new_btns, registerButton(btn_data))
	end
	
	return gears.table.join(table.unpack(new_btns))
end



-------------------------------------------
-- TAG KEYS
-------------------------------------------

local tag_controls = {
	{
		combo	= config.tag_view_combo or "Mod + %s",
		desc	= "View tag",
		press	= function(tag)
			tag:view_only()
		end,
	},{
		combo	= config.tag_move_combo or "Mod + Shift + %s",
		desc	= "Move client to tag",
		press	= function(tag)
			client.focus:move_to_tag(tag)
			if config.follow_clients then
				tag:view_only()
			end
		end,
	},{
		combo	= config.tag_toggle_combo or "Mod + Control + %s",
		desc	= "Toggle tag",
		press	= function(tag)
			awful.tag.viewtoggle(tag)
		end
	},{
		combo	= config.tag_toggle_client_combo or "Mod + Control + Shift + %s",
		desc	= "Merge client to tag",
		press	= function(tag)
			client.focus:toggle_tag(tag)
		end
	}
}

local screen_tag_actuators = {}
local registered_tag_combos = {}

function bind.generateTagKeys(scr)
	
	-- Lookup table
	screen_tag_actuators[scr] = {}
	for _, tag in ipairs(scr.tags) do
		local actuator = tag.actuator or "#"..tag.index+9
		screen_tag_actuators[scr][actuator] = tag
	end
	
	-- All tags of the provided screen
	for _, scr_tag in ipairs(scr.tags) do
		local actuator = scr_tag.actuator or "#"..scr_tag.index+9
		
		-- Basic tag control functions
		for _, tag_control in ipairs(tag_controls) do
			local combo = string.format(tag_control.combo, actuator)
			if not registered_tag_combos[combo] then
				
				bind.globalKey {
					combo	= combo,
					desc	= tag_control.desc,
					group	= "Tag",
					press	= function()
						local screen = awful.screen.focused()
						local tag = screen_tag_actuators[screen][actuator]
						if tag then
							tag_control.press(tag)
						end
					end,
				}
				
				registered_tag_combos[combo] = true
			end
		end
		
	end
	
end

-------------------------------------------

return bind
