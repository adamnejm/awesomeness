
-- Handy functions required by other ness libraries to work
local util = {}



-------------------------------------------
-- GENERAL / ROOT
-------------------------------------------

--- Returns first defined value in the given list
-- @param ... List of any values
function util.getFirstDefined(...)
	for i = 1, select("#", ...) do
		local v = select(i, ...)
		if v~=nil then
			return v
		end
	end
end



-------------------------------------------
-- TABLE
-------------------------------------------

util.table = {}

--- Returns count of elements in unsequential tables
-- @param tbl Table to get the count of
-- @return Number of elements
function util.table.count(tbl)
	local n = 0
	for _ in pairs(tbl) do
		n = n + 1
	end
	return n
end

--- Checks if table is unsequential table is empty
-- @param tbl Table to check
-- @return Boolean, True if empty
function util.table.isEmpty(tbl)
	return next(tbl) == nil
end

--- Returns highest index in a non-sequential table or `nil` if it doesn't contain any numerical indices
-- @param tbl Table to check
function util.table.highest(tbl)
	local highest
	for i in pairs(tbl) do
		if type(i) == "number" then
			if not highest or (highest and i > highest) then
				highest = i
			end
		end
	end
	return highest
end

--- Checks whether a table contains the given value
-- @param tbl Table to look in
-- @param value Element to look for
-- @param case_insensitive In case looking for string, this can be set to lower both the given value and the element it checks against
function util.table.hasValue(tbl, value, case_insensitive)
	if case_insensitive then
		value = string.lower(value)
		
		for k, v in pairs(tbl) do
			if type(v) == "string" and string.lower(v) == value then
				return true
			end
		end
		return
	else
		for k, v in pairs(tbl) do
			if v == value then
				return true
			end
		end
	end
end

--- Merges tables together iterating recursively over the children overriding existing elements
-- @param target Table to modify
-- @param source Table to get the data from
-- @return Table `target` which has been modified
function util.table.merge(target, source)
	for k, v in pairs(source) do
		if type(v) == "table" and type(target[k]) == "table" then
			util.table.merge(target[k], v)
		else
			target[k] = v
		end
	end
			
	return target
end



-------------------------------------------
-- STRING
-------------------------------------------

util.string = {}

--- Splits string given a separator into a table
-- @credits http://lua-users.org/wiki/SplitJoin
-- @param str String to process
-- @param pat String patter separator
-- @param trim Boolean whether or not to trim spaces off of the found elements
-- @return Table of found Strings
function util.string.split(str, pat, trim)
	local t = {}
	local fpat = "(.-)" .. pat
	local last_end = 1
	local s, e, cap = str:find(fpat, 1)
		while s do
		if s ~= 1 or cap ~= "" then
		table.insert(t, trim and util.string.trim(cap) or cap)
		end
	last_end = e+1
	s, e, cap = str:find(fpat, last_end)
	end
	
	if last_end <= #str then
		cap = str:sub(last_end)
		table.insert(t, trim and util.string.trim(cap) or cap)
	end
	
	return t
end

--- Removes spaces at the end and beginning of a given string
-- @credits http://lua-users.org/wiki/StringTrim
-- @param str String to process
-- @return String without starting or ending spaces
function util.string.trim(str)
	return (str:gsub("^%s*(.-)%s*$", "%1"))
end



return util



