_ = require('vendor/lodash/src/lodash')

-- ARRAYS

_.push = (array, value) -> table.insert(array, value)

_.join = (value, delimiter) -> table.concat(value, delimiter)

-- STRINGS

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

return _
