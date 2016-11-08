Command = require('lib/commands/command')
Vector = require('lib/geo/vector')
Direction = require('lib/geo/direction')

class MoveCommand extends Command

	new: (@entity, @velocity, @speed) =>

	exec: () =>
		if @velocity.class == Direction
			speed = if @speed then @speed else @entity.maxSpeed
			@velocity = Vector(@velocity, speed)

		@entity\set('velocity', @velocity)
		@entity.animation.value\resume()

	undo: () =>
		{ :velocity } = @entity\get()
		@entity\set('velocity', velocity - @velocity)
