Steering = require('lib/behaviors/steering/steering')
Vector = require('lib/geo/vector')
Flee = require('lib/behaviors/steering/flee')

-- Steers toward target
class Evade extends Steering

	new: (entity, @target, @behavior = Flee(entity)) => super(entity)

	setTarget: (target) => @behavior\setTarget(target)

	run: (dt) =>
		{ :position, :velocity, :maxSpeed, :maxForce } = @entity\get()
		if not velocity then velocity = Vector.ZERO
		maxSpeed *= dt

		distance = @target.position - position
		T = math.ceil(distance\getLength() / @target.maxSpeed)
		target = @target.position + (@target.velocity or 0) * T
		@setTarget(target)

		return @behavior\run(dt)
