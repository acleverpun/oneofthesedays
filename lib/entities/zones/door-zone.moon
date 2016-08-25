entities = require('lib/entities')
Zone = require('lib/entities/zones/zone')

class DoorZone extends Zone
	onEnter: (entity, collision) =>
		if entity.class == entities.Player
			@enter(entity, collision)

	enter: (entity, collision) =>
		-- TODO: Move some of this logic to Transition
		{ :map } = @data.properties
		if not map then map = @state.previous.mapName

		-- TODO: Wat?
		{ :offset, :direction } = collision
		@state\switch(@state.__class(map), { :offset, :direction })
