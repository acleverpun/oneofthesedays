entities = require('lib/entities')
Tile = require('lib/entities/tiles/tile')

class WarpTile extends Tile
	new: (...) =>
		super(...)

	onEnter: (entity) =>
		if entity.class != entities.Player then return
