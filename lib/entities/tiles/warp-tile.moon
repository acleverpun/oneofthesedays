entities = require('lib/entities')
Tile = require('lib/entities/tiles/tile')

class WarpTile extends Tile
	onEnter: (entity) =>
		if entity.class == entities.Player
			@warp()

	warp: () =>
		{ :map } = @tile.properties
		if not map then map = @state.previous.mapName
		@state\switch(@state.__class(map))
