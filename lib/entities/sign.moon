MyEntity = require('lib/entities/my-entity')

class Sign extends MyEntity

	new: (...) =>
		super(...)
		@text = @data.properties.text

	onUse: (entity, col) =>
		print "Sign: #{@text}"
