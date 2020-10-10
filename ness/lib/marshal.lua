
local config	= require("config", true)
local util		= require("ness/lib/util")
local bind		= require("ness/lib/bind")
local awful		= require("awful")


-- Library responsible for configuration and comatibility (to ease using 3rd party modules)
local marshal = {}

function marshal.merge(tbl)
	return util.table.merge(config, tbl)
end

function marshal.applyConfiguration()
	modkey = config.default_modifier
	awful.layout.layouts = config.allowed_layouts
	
	bind.ignoreAwfulModifiers()
	
	if config.app_hotkeys then
		require("awful.hotkeys_popup.keys")
	end
end

function marshal.applyCompatibility()
	terminal	= config.terminal
	editor		= config.editor
	editor_cmd	= string.format(config.editor_command, config.terminal, config.editor)
	modkey		= config.default_modifier
end

-------------------------------------------

return marshal
