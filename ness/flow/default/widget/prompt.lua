
-- Default AwesomeMW prompt widget

local awful = require("awful")

-------------------------------------------

-- Wrapped, because Lua's `require` caches the results and we need it instantiated for each screen
return function()
	
	return awful.widget.prompt()
	
end
