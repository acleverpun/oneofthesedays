Class = require('lib/class')

class Enum extends Class
	@add: (values) =>
		assert _.isTable(values)

		for key, value in pairs(values)
			if _.isNumber(key) then key = value
			@[key] = @(value)
