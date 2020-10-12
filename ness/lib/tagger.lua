
local config	= require("config", true)
local flower	= require("ness/lib/flower")
local gfs		= require("gears.filesystem")
local awful		= require("awful")
local gears		= require("gears")
local util		= require("ness/lib/util")


-- Manages screens and tags
local tagger = {}



-------------------------------------------
-- SCREEN
-------------------------------------------

--- Attaches `cfg` key which is a slice of `config` that specifies the passed `screen` object
-- @param scr Screen object to identify
function tagger.setupScreenConfig(scr)
	if scr.cfg then return end
	
	-- Index identifier
	if config.screens[scr.index] then
		scr.cfg = config.screens[scr.index]
		return
	end
	
	-- XRandR name
	if scr.outputs then
		for xrandr_name, geometry in pairs(scr.outputs) do
			for name, cfg in pairs(config.screens) do
				if gears.string.startswith(xrandr_name, name) then
					scr.cfg = cfg
					return
				end
			end
		end
	end
	
	-- Default or empty config
	scr.cfg = config.screens["*"] or {}
end

--- Sets wallpaper for the screen based on the static configuration
function tagger.setWallpaper(scr)
	local wallpaper = scr.cfg.wallpaper
	if not wallpaper then return end
	
	local path
	if gfs.file_readable(wallpaper) then
		-- Check if path is global
		path = wallpaper
	elseif gfs.file_readable(flower.getThemeDir().."wallpaper/"..wallpaper) then
		-- Check if path is local to `theme/wallpaper/`
		path = flower.getThemeDir().."wallpaper/"..wallpaper
	elseif gfs.file_readable(flower.getThemeDir()..wallpaper) then
		-- Additionally check relative to base theme directory
		path = flower.getThemeDir()..wallpaper
	end
	
	if path then
		local mode = scr.cfg.wallpaper_mode or "centered"
		
		local scale = scr.cfg.wallpaper_scale or 1
		local offset = scr.cfg.wallpaper_offset
		local no_aspect = util.getFirstDefined(scr.cfg.wallpaper_ignore_aspect, true)
		local background = scr.cfg.wallpaper_background or "#000000"
		
		if mode == "centered" then
			gears.wallpaper.centered(path, scr, background, scale)
		elseif mode == "maximized" then
			gears.wallpaper.maximized(path, scr, no_aspect, offset)
		elseif mode == "tiled" then
			gears.wallpaper.tiled(path, scr, offset)
		elseif mode == "fit" then
			gears.wallpaper.fit(path, scr, background)
		end
	end
	
end



-------------------------------------------
-- TAG
-------------------------------------------

--- Handles creation of tags for the passed `screen` object based on their `cfg` key
-- @param scr Screen to create the tags for
function tagger.createTags(scr)
	local scr_cfg = scr.cfg
	
	-- Determine how many tags screen needs based on `tag_count` or the highest defined index in `tags` table
	local count = scr_cfg.tag_count or (scr_cfg.tags and util.table.highest(scr_cfg.tags)) or 9
	
	-- Create tags
	for i = 1, count do
		-- TODO: Add screen-independent config for how the default tag looks like
		local tag_cfg = scr_cfg.tags and scr_cfg.tags[i] or {}
		
		-- Additional values
		tag_cfg.screen = scr
		tag_cfg.layout = tag_cfg.layout or config.allowed_layouts[1]
		tag_cfg.selected = tag_cfg.selected~=nil and tag_cfg.selected or i == 1
		
		awful.tag.add(tag_cfg.name or i, tag_cfg)
	end
end

-------------------------------------------

return tagger
