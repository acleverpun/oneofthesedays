entities = require('lib/entities')
Zone = require('lib/entities/zones/zone')

class DoorZone extends Zone
	onEnter: (entity) =>
		if entity.class == entities.Player
			@warp()

	warp: () =>
		{ :map } = @data.properties
		if not map then map = @state.previous.mapName
		@state\switch(@state.__class(map))
