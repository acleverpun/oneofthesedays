Steering = require('lib/behaviors/steering/steering')
Vector = require('lib/geo/vector')

-- Steers toward target
class Seek extends Steering

	new: (entity, @behavior) => super(entity)

	run: (dt) =>
		{ :velocity, :maxSpeed, :maxForce } = @entity\get()
		if not velocity then velocity = Vector.ZERO
		maxSpeed *= dt

		desiredVelocity = @behavior\run(dt)
		steering = (desiredVelocity - velocity)\truncate(maxForce)
		velocity = (velocity + steering)\truncate(maxSpeed)
		return velocity
