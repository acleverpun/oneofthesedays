Class = require('lib/class')

class Transition extends Class

	new: (@fromScene, @toScene, data = {}) =>
		@player = data.player or @fromScene.player
		@fromWarp = data.fromWarp
		@toWarp = data.toWarp
		@toPosition = data.toPosition
		@offset = data.offset
		@direction = data.direction
