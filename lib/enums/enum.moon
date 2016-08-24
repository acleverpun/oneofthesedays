Base = require('lib/base')

class Enum extends Base
	-- new: (values) =>
	-- 	assert _.isTable(values)
	-- 	if _.isArray(values)
	-- 		for value in *values
	-- 			@[value] = value
	-- 	else
	-- 		for key, value in pairs(values)
	-- 			@[key] = value
