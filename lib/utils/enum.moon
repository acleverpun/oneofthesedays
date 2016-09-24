Caste = require('vendor/caste/lib/caste')

-- TODO: freeze
class Enum extends Caste

	keys: {}
	values: {}

	new: (values) =>
		if not _.isTable(values) then error 'Expected table.'

		for key, value in pairs(values)
			@[key] = value
			@[value] = value
			_.push(@keys, key)
			_.push(@values, value)
