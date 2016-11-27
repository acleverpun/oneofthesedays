_ = require('vendor/lodash/src/lodash')

-- ARRAY

_.push = (array, ...) ->
	args = { ... }
	for value in *args
		table.insert(array, value)

_.join = (value, delimiter) -> table.concat(value, delimiter)

-- LANG

_.isArray = (value) ->
	if not _.isTable(value) then return false
	for key in pairs(value) do
		if type(key) != 'number' then return false
	return true

_.isPlainTable = (value) ->
	if not _.isTable(value) then return false
	for key in pairs(value) do
		if type(key) == 'number' then return false
	return true

_.isInstance = (value) -> not not value.isInstance
_.isClass = (value) -> not not value.isClass

-- MATH

_.round = (value, precision = 0) ->
	factor = 10^(precision)
	return math.floor(value * factor + 0.5) / factor

-- OBJECT

---
 -- Merges n tables together.
 --
 -- @method merge
 -- @param {Table} target - the destination table
 -- @param {Table} ...sources - the source tables
 -- @return {Table} - the merged table
 --
_.merge = (target, ...) ->
	sources = { ... }
	for source in *sources
		for key, value in pairs(source)
			if (type(value) == 'table') and (type(target[key] or false) == 'table')
				_.merge(target[key], source[key])
			else
				target[key] = value
	return target

---
 -- Sets defaults from n tables
 --
 -- @method defaults
 -- @param {Table} target - the destination table
 -- @param {Table} ...sources - the source tables
 -- @return {Table} - the defaulted table
 --
_.defaults = (target, ...) ->
	sources = { ... }
	for source in *sources
		for key, value in pairs(source)
			if (type(value) == 'table') and (type(target[key] or false) == 'table') and not target.isInstance and not target.isClass
				_.defaults(target[key], source[key])
			elseif not target[key]
				target[key] = value
	return target

-- STRING

_.split = (value, delimiter) ->
	result = {}
	fromIndex = 1
	delimFrom, delimTo = string.find(value, delimiter, fromIndex)
	while delimFrom
		table.insert(result, string.sub(value, fromIndex , delimFrom - 1))
		fromIndex = delimTo + 1
		delimFrom, delimTo = string.find(value, delimiter, fromIndex)
	table.insert(result, string.sub(value, fromIndex))
	return result

_.lowerCase = (value) -> string.lower(value)

_.upperCase = (value) -> string.lower(value)

_.lowerFirst = (value) ->
	first = string.lower(string.sub(value, 1, 1))
	rest = string.sub(value, 2)
	return "#{first}#{rest}"

_.upperFirst = (value) ->
	first = string.upper(string.sub(value, 1, 1))
	rest = string.sub(value, 2)
	return "#{first}#{rest}"

_.kebabCase = (value) ->
	value = string.gsub(value, '([a-z])([A-Z])', '%1-%2')
	return _.lowerCase(value)

return _
