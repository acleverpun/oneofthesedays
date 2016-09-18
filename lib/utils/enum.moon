Caste = require('vendor/caste/lib/caste')

class Enum extends Caste

	@add: (values) =>
		unless _.isTable(values) then error 'Expected table.'

		for key, value in pairs(values)
			if _.isNumber(key) then key = value
			enum = @(value, key)
			@[key] = enum
			@[value] = enum
			_.push(@keys, key)
			_.push(@values, value)

	keys: {}
	values: {}

	new: (@value, @key) =>
