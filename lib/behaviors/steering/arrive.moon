Steering = require('lib/behaviors/steering/steering')
Vector = require('lib/geo/vector')

-- Arrives at target
class Arrive extends Steering

	new: (entity, @target, @slowingRadius) => super(entity)

	run: (dt) =>
		{ :position, :velocity, :maxSpeed, :maxForce } = @entity\get()
		if not velocity then velocity = Vector.ZERO
		maxSpeed *= dt

		desiredVelocity = @target - position
		distance = desiredVelocity\getLength()

		if distance < @slowingRadius
			desiredVelocity = Vector(desiredVelocity, maxSpeed * distance / @slowingRadius)
		else
			desiredVelocity = Vector(desiredVelocity, maxSpeed)

		steering = desiredVelocity - velocity
		velocity = (velocity + steering)\truncate(maxSpeed)
		return velocity
