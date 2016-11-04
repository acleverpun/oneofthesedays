entities = require('lib/entities')
Zone = require('lib/entities/zones/zone')

class Warp extends Zone

	onEnter: (entity, collision) =>
		if entity.class == entities.Player
			@enter(entity, collision)

	enter: (entity, collision) =>
		-- TODO: Move some of this logic to Transition
		{ :map } = @tile.properties
		if not map then map = @scene.previous.map.id

		-- TODO: Wat?
		@scene\switch(@scene.__class(map), @getTransitionData(collision))

	getTransitionData: (collision) =>
		collision.fromWarp = @
		return collision
