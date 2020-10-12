
local gfs		= require("gears.filesystem")
local beautiful = require("beautiful")


local flower = {
	initialized = nil,
	fallback = "default",
	
	theme = "default",
}

-------------------------------------------

local require_function = require

local require_cache = {}
local function cachePath(flow, path, require_path)
	if not require_cache[flow] then
		require_cache[flow] = {}
	end
	require_cache[flow][path] = require_path
end



-------------------------------------------
-- PATH
-------------------------------------------

--- Converts global path to a path that's local to Awesome's configuration folder
-- @param path Global path to convert
-- @return Local path or the provided global path if not successful
function flower.getLocalPath(path)
	path = path:gsub(gfs.get_configuration_dir(), "")
	return path
end

--- Converts local path to global path by concatenating Awesome's configuration dir to the beginning
-- @param path Local path to convert
-- @return Global path with prepended Awesome's config dir
function flower.getGlobalPath(path)
	return gfs.get_configuration_dir()..path
end

--- Returns path of the currently executing file
-- @param stack Optional stack level of the `debug.getinfo`
-- @return Path to the current file
function flower.getExecFile(stack)
	local info = debug.getinfo(stack or 3)
	return info and info.source:sub(2)
end

--- Returns directory of the currently executing file
-- @param stack Optional stack level of the `debug.getinfo`
-- @return Path to the current file's directory
function flower.getExecDir(stack)
	local info = debug.getinfo(stack or 3)
	return info and info.source:match("@?(.*/)")
end



-------------------------------------------
-- THEME
-------------------------------------------

--- Returns path to directory of the specified or currently set theme
-- @param theme Theme get the path for
-- @return Path to the theme directory
function flower.getThemeDir(theme)
	return flower.getGlobalPath("ness/theme/"..(theme or flower.theme).."/")
end

--- Returns global path to initializing file of the specified theme if it exists, errors otherwise
-- @param theme Theme directory name located by default in ~/.config/awesome/ness/theme/
-- @param file Optional file to load, if `nil` it will use `theme.lua`
-- @return Global theme path
function flower.getThemeFile(theme, file)
	local path = flower.getThemeDir(theme)..(file or "theme.lua")
	if gfs.file_readable(path) then
		return path
	else
		error("Can't find specified theme!, please confirm the path: "..path)
	end
end

--- Returns currently executing theme, available only inside the executing theme directory, ie. ness/theme/default/
-- @return Theme that's currently executing
function flower.getExecTheme(stack)
	local dir = flower.getExecDir(stack)
	return dir and dir:match("ness/theme/([^/]*)")
end

--- Available only in the theme file, returns path to it's directory
-- @return Currently executing theme path
function flower.getExecThemeDir()
	local theme = flower.getExecTheme(4)
	return theme and flower.getThemeDir(theme)
end

--- Uses beautiful to set the current theme
-- @param theme Theme directory name located by default in ~/.config/awesome/ness/theme/
-- @param file Optional file to load, if `nil` it will use `theme.lua`
function flower.setTheme(theme, file)
	flower.theme = theme
	beautiful.init(flower.getThemeFile(theme, file))
end



-------------------------------------------
-- FLOW
-------------------------------------------

--- Sets the fallback Flow, if a file isn't found in the currently executing Flow, this Flow will be used
function flower.setFallback(flow)
	flower.fallback = flow or "default"
end

function flower.getFallback(flow)
	return flower.fallback
end

--- Returns Flow of the currently executing file
-- @param stack Optional stack level of the `debug.getinfo`
-- @return Flow's name or `nil` if not in a Flow
function flower.getExecFlow(stack)
	local dir = flower.getExecDir(stack)
	return dir and dir:match("ness/flow/([^/]*)")
end

--- Returns Flow's directory
-- @param flow Name of the Flow
-- @param global Whether to provide global path instead of local one
function flower.getFlowDir(flow, global)
	if global then
		return flower.getGlobalPath(flower.getFlowDir(flow))
	else
		return "ness/flow/"..flow.."/"
	end
end

--- Checks if provided Flow has a file then returns it's path local to the Awesome's directory
-- @param flow Flow check in
-- @param path Flow's path
-- @return Path local to Awesome's base directory or `nil` if file not found
function flower.getFilePath(flow, path)
	if gfs.file_readable(flower.getFlowDir(flow, true)..path..".lua") then
		return flower.getFlowDir(flow)..path
	end
end

--- Sets the function used to require file, by default this is global Lua's `require`
-- @param func Function to use instead
function flower.setRequireFunction(func)
	require_function = func
end

--- Loads Lua file and returns it, but first looks in current Flow and fallback Flow, then requires normally
-- @param path Path of the file to require
-- @param flow Optional flow to require from, can be boolean to use currently initialized Flow
function flower.require(path, flow)
	local force_flow = flow~=nil
	flow = flow == true and flower.initialized or flow or flower.getExecFlow(4)
	
	if not flow then
		return require_function(path)
	else
		if require_cache[flow] and require_cache[flow][path] then
			return require_function(require_cache[flow][path])
		else
			local require_path
			if force_flow then
				-- If a flow is provided, user is sure that he doesn't want a fallback
				require_path = flower.getFlowDir(flow)..path
			else
				-- Try using in order: 1. Current executing Flow; 2. Fallback Flow; 3. Original path
				require_path = flower.getFilePath(flow, path) or flower.getFilePath(flower.fallback, path) or path
			end
			
			cachePath(flow, path, require_path)
			return require_function(require_path)
		end
	end
end

--- Initializes / loads a Flow by it's name from the `ness/flow` directory
-- @param flow Flow name, if `nil` it will error so the user doesn't get stuck without WM
-- @param path Optional path to the file, by default this will be `rc` to load `rc.lua`
function flower.initialize(flow, path)
	flower.initialized = flow
	path = path or "rc"
	
	if not flow then
		error("You must provide name of the Flow to initialize")
	end
	
	if gfs.file_readable(flower.getFlowDir(flow, true)..path..".lua") then
		return require_function(flower.getFlowDir(flow)..path)
	else
		error("Flow by that doesn't exist or doesn't have a specified starting file")
	end
end

-------------------------------------------

return flower
