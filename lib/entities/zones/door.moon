Warp = require('lib/entities/zones/warp')

class Door extends Warp

	getTransitionData: (collision) =>
		transitionData = super(collision)
		transitionData.toWarp = @tile.properties.door
		return transitionData
