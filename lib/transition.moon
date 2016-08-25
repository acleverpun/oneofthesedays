Base = require('lib/base')

class Transition extends Base
	new: (@fromState, @toState, data = {}) =>
		@player = data.player or @fromState.player
		@fromDoor = data.fromDoor
		@toDoor = data.toDoor
		@toPoint = data.toPoint
		@offset = data.offset
		@direction = data.direction
