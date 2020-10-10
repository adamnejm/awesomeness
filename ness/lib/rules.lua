
local awful = require("awful")


-- Middleman for the `awful.rules.rules` table, simplifying it's usage and handling the default client properties
local rules = {}



-------------------------------------------
-- DEFAULT RULESET
-------------------------------------------

if not awful.rules.rules[1] then
	awful.rules.rules[1] = {
		id = "default",
		rule = {},
		properties = {},
	}
end


-- REFERENCES

local rules_all = awful.rules.rules
local rules_default = awful.rules.rules[1]



-------------------------------------------
-- MANAGEMENT
-------------------------------------------

function rules.setDefault(tbl)
	rules_default = tbl
end

function rules.getDefault()
	return rules_default
end

function rules.setDefaultProperties(tbl)
	rules_default.properties = tbl
end

function rules.getDefaultProperties()
	return rules_default.properties
end

function rules.set(tbl)
	-- Remove everything, but the default ruleset
	for i = 2, #rules_all do
		rules_all[i] = nil
	end
	
	-- Insert the new rules
	for i, ruleset in ipairs(tbl) do
		rules_all[i + 1] = ruleset
	end
end

function rules.append(tbl)
	for _, ruleset in ipairs(tbl) do
		ruleset.id = ruleset.id or #rules_all + 1
		table.insert(rules_all, ruleset)
	end
end

function rules.add(tbl)
	tbl.id = tbl.id or #rules_all + 1
	table.insert(rules_all, tbl)
end

function rules.remove(id)
	-- Remove by `id` key inside of the ruleset
	for i = 2, #rules_all do
		if rules_all[i].id == id then
			table.remove(rules_all, id)
			return
		end
	end
end

-------------------------------------------

return rules
