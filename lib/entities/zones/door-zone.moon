entities = require('lib/entities')
Zone = require('lib/entities/zones/zone')

class DoorZone extends Zone
	onEnter: (entity, collision) =>
		if entity.class == entities.Player
			@enter(entity, collision)

	enter: (entity, collision) =>
		-- TODO: Move some of this logic to Transition
		{ :map, :door } = @data.properties
		if not map then map = @scene.previous.mapName

		-- TODO: Wat?
		{ :offset, :direction } = collision
		@scene\switch(@scene.__class(map), { :offset, :direction, fromDoor: @, toDoor: door })
