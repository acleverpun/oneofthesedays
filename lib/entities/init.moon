Loader = require('lib/loader')

Loader((key) ->
	file = _.kebabCase(key)
	return require("lib/entities/#{file}")
)
