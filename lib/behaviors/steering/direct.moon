Steering = require('lib/behaviors/steering/steering')
Vector = require('lib/geo/vector')

-- Direct path to target
class Direct extends Steering

	new: (entity, @target) => super(entity)

	run: () =>
		{ :position, :maxSpeed } = @entity\get()
		return Vector(@target - position, maxSpeed)
