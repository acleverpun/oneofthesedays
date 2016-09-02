Entity = require('lib/entities/entity')

class Sign extends Entity

	new: (...) =>
		super(...)
		@text = @data.properties.text

	onUse: (entity, col) =>
		print "Sign: #{@text}"
