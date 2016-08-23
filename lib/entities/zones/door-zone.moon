entities = require('lib/entities')
Zone = require('lib/entities/zones/zone')

class DoorZone extends Zone
	onTouch: (entity) =>
		if entity.class == entities.Player
			@enter(entity)

	enter: (entity) =>
		-- TODO: Move some of this logic to Transition
		{ :map } = @data.properties
		if not map then map = @state.previous.mapName

		{ :x, :y } = entity\get('Position')
		offsetX = x - @data.x
		offsetY = y - @data.y

		data = { fromDoor: { :offsetX, :offsetY } }
		@state\switch(@state.__class(map), data)