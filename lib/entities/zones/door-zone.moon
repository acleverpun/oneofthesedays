WarpZone = require('lib/entities/zones/warp-zone')

class DoorZone extends WarpZone

	getTransitionData: (collision) =>
		transitionData = super(collision)
		transitionData.toWarp = @data.properties.door
		return transitionData
