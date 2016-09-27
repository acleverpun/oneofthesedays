Caste = require('vendor/caste/lib/caste')

class Tile extends Caste

	new: (data) =>
		@id = data.id
		@properties = data.properties
