Class = require('lib/class')

class Transition extends Class
	new: (@fromScene, @toScene, data = {}) =>
		@player = data.player or @fromScene.player
		@fromDoor = data.fromDoor
		@toDoor = data.toDoor
		@toPoint = data.toPoint
		@offset = data.offset
		@direction = data.direction
