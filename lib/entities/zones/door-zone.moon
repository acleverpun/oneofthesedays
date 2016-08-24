entities = require('lib/entities')
Zone = require('lib/entities/zones/zone')

class DoorZone extends Zone
	onEnter: (entity) =>
		if entity.class == entities.Player
			@enter(entity)

	enter: (entity) =>
		-- TODO: Move some of this logic to Transition
		{ :map } = @data.properties
		if not map then map = @state.previous.mapName

		offset = entity\get('Position').point - @data
		@state\switch(@state.__class(map), { :offset })
