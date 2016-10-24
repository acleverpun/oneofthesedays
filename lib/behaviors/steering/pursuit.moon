Steering = require('lib/behaviors/steering/steering')
Vector = require('lib/geo/vector')
Seek = require('lib/behaviors/steering/seek')

-- Steers toward target
class Pursuit extends Steering

	new: (entity, @behavior = Seek(entity), @projection = 3) => super(entity)

	setTarget: (target) => @behavior\setTarget(target)

	run: (dt) =>
		{ :position, :velocity, :maxSpeed, :maxForce } = @entity\get()
		if not velocity then velocity = Vector.ZERO
		maxSpeed *= dt

		target = position + velocity * @projection
		@setTarget(target)

		return @behavior\run(dt)
