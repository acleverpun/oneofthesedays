Entity = require('lib/entities/entity')

class Sign extends Entity

	new: (...) =>
		super(...)
		@value = @data.properties.value

	onUse: (entity, col) =>
		print "Sign: #{@value}"
