Entity = require('lib/entities/entity')

class Sign extends Entity

	new: (...) =>
		super(...)
		@text = @tile.properties.text

	onUse: (entity) =>
		print "Sign: #{@text}"
