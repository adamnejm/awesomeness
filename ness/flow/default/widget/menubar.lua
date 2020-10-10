
-- Default Awesome menubar widget

local config = require("config")

-------------------------------------------

local menubar = require("menubar")
menubar.utils.terminal = config.terminal

return menubar

