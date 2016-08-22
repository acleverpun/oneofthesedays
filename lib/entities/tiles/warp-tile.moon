states = require('vendor/hump/gamestate')
entities = require('lib/entities')
Tile = require('lib/entities/tiles/tile')
ZoneState = require('lib/states/zone')

class WarpTile extends Tile
	new: (...) =>
		super(...)

	onEnter: (entity) =>
		if entity.class == entities.Player
			@warp()

	warp: () =>
		if map = @tile.properties.map
			states.switch(ZoneState(map))
