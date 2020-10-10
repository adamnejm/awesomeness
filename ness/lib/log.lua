
-- Log library used to debug shit, drunkcode in it's essence, needs to be rewritten
local log = {
	path = os.getenv("HOME").."/.config/awesome/ness/log.txt"
}

-------------------------------------------

local function logTbl(tbl, file, levels, indent)
	local ind = string.rep("\t", indent)
	for k, v in pairs(tbl) do
		if type(v) == "table" and levels > 1 then
			file:write(ind .. tostring(k) .. " = {\n")
				logTbl(v, file, levels - 1, indent + 1)
			file:write(ind .. "},\n")
		else
			file:write(ind .. tostring(k) .. " = " .. tostring(v) .. ",\n")
		end
	end
end

-------------------------------------------

function log.setPath(path)
	log.path = path
end

function log.backup()
	local l = io.open(log.path, "r")
	local b = io.open(log.path..".bak", "a")
	b:write(l:read("*all"))
	b:close()
	l:close()
	
end

function log.clear()
	local file = io.open(log.path, "w")
	file:close()
end

function log.date()
	local d = os.date("%d/%m/%y  --  %H:%M:%S")
	local s = "--------" .. string.rep("-", #d)
	log.print(s)
	log.print("--  "..d.."  --")
	log.print(s.."\n")
end

function log.print(...)
	local file = io.open(log.path, "a")
	local len, str = select("#", ...), ""
	for i = 1, len do
		str = str .. tostring(select(i, ...)) .. (i < len and " " or "")
	end
	
	file:write(tostring(str), "\n")
	file:close()
end

function log.table(tbl, levels, indent)
	levels = levels or 10
	indent = indent or 1
	
	local file = io.open(log.path, "a")
		file:write(string.sub(tostring(tbl), 8) .. " = {\n")
			logTbl(tbl, file, levels, indent)
		file:write("}\n")
	file:close()
end

-------------------------------------------

local log_mt = {}

function log_mt.__call(self, ...)
	return log.print(...)
end

return setmetatable(log, log_mt)