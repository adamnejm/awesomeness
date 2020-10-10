
local naughty = require("naughty")


-- Notification library
local notify = {}

-------------------------------------------

function notify.runtimeError(err)
	
	local title, text
	local br = string.find(err, ": ", 1, true)
	if br then
		title = string.sub(err, 1, br-1)
		text = string.sub(err, br+2, -1)
	end
	
	naughty.notify {
		preset	= naughty.config.presets.critical,
		title	= title or "ERROR!",
		text	= text or err,
	}
end

-------------------------------------------

return notify
