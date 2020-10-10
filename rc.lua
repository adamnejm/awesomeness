
----------------------------------------------------------
--                                                      --
--  A ███▙   ████  ██████████  ██████████  ██████████   --
--  W ████▙  ████  ██████████  ██████████  ██████████   --
--  E █████▙ ████  ████        ████        ████         --
--  S ██████▙████  ███████     ██████████  ██████████   --
--  O ████▜██████  ███████     ██████████  ██████████   --
--  M ████ ▜█████  ████              ████        ████   --
--  E ████  ▜████  ██████████  ██████████  ██████████   --
--  / ████   ▜███  ██████████  ██████████  ██████████   --
--                                            	        --
----------------------------------------------------------

-- If you need to debug something, you can uncomment this, ignore otherwise
-- Log library provides few useful functions like log(...) or log.table(tbl)
-- log = require("ness/lib/log")
-- log.clear()

----------------------------------------------------------

-- Flower library is mainly responsible for handling the Flow system
-- Flows are identified by their directory name, by default located in ~/.config/awesome/ness/flow/<FLOW_NAME>/
local flower = require("ness/lib/flower")

-- Supercharge the default `require` with additional functionality of the Flow system
-- This will allow for easy file including from the currently executing Flow,
-- borrowing files from other Flows or automatically using the specified fallback Flow
require = flower.require

-- Set the Flow to use as a fallback in case a file we're trying to include is missing from the
-- currently executing Flow, especially useful when creating custom Flow based on a different one
flower.setFallback("default")

-- Load the rc.lua file from the Flow specified below
-- You can also pass a second argument start initialization at a different file from that Flow
flower.initialize("default")

----------------------------------------------------------

-- Rest of the configuration belongs to the Flow so take a look at it's starting file
