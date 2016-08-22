entities = require('lib/entities')
Zone = require('lib/entities/zones/zone')

class DoorZone extends Zone
	onTouch: (entity) =>
		if entity.class == entities.Player
			@enter()

	enter: () =>
		{ :map } = @data.properties
		if not map then map = @state.previous.mapName
		@state\switch(@state.__class(map))
