Loader = require('lib/loader')

Loader((name) =>
	file = _.kebabCase(name)
	return require("lib/entities/#{file}")
)
