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
		{ :map, :enter, :exit } = @tile.properties
		if map
			method = if enter then 'push' else 'switch'
			states[method](ZoneState(map))
		elseif exit
			states.pop()

