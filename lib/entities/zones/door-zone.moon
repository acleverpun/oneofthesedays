BoundaryZone = require('lib/entities/zones/boundary-zone')

class DoorZone extends BoundaryZone

	getTransitionData: (collision) =>
		transitionData = super(collision)
		transitionData.fromDoor = @
		transitionData.toDoor = @data.properties.door
		return transitionData
