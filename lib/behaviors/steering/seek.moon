Steering = require('lib/behaviors/steering/steering')
Vector = require('lib/geo/vector')
Direct = require('lib/behaviors/steering/direct')

-- Steers toward target
class Seek extends Steering

	new: (entity, @behavior = Direct(entity)) => super(entity)

	setTarget: (target) => @behavior\setTarget(target)

	run: (dt) =>
		{ :velocity, :maxSpeed, :maxForce } = @entity\get()
		if not velocity then velocity = Vector.ZERO
		maxSpeed *= dt

		desiredVelocity = @behavior\run(dt)
		steering = (desiredVelocity - velocity)\truncate(maxForce)
		velocity = (velocity + steering)\truncate(maxSpeed)
		return velocity
