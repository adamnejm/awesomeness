
-- Default Awesome menubar widget

local config = require("config", true)

-------------------------------------------

local menubar = require("menubar")
menubar.utils.terminal = config.terminal

return menubar

