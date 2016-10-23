Steering = require('lib/behaviors/steering/steering')
Vector = require('lib/geo/vector')

-- Direct path to target
class Direct extends Steering

	new: (entity) =>
		super(entity)
		@target = entity\get('target')
		if not @target then error('No target specified.')

	run: (dt) =>
		{ :position, :maxSpeed } = @entity\get()
		maxSpeed *= dt
		return Vector(@target - position, maxSpeed)
