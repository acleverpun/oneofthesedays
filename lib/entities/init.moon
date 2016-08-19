(type) ->
	file = _.kebabCase(type)
	require("lib/entities/#{file}")
