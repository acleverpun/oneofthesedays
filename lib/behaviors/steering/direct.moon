Steering = require('lib/behaviors/steering/steering')
Vector = require('lib/geo/vector')

-- Direct path to target
class Direct extends Steering

	new: (entity, @target) => super(entity)

	run: (dt) =>
		{ :position, :maxSpeed } = @entity\get()
		maxSpeed *= dt
		return Vector(@target - position, maxSpeed)
