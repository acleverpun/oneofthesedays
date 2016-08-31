Warp = require('lib/entities/zones/warp')

class Door extends Warp

	getTransitionData: (collision) =>
		transitionData = super(collision)
		transitionData.toWarp = @data.properties.door
		return transitionData
