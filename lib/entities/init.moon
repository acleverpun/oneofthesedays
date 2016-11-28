Loader = require('vendor/hug/lib/loader')

Loader((key) ->
	file = _.kebabCase(key)
	return require("lib/entities/#{file}")
)
