Steering = require('lib/behaviors/steering/steering')
Vector = require('lib/geo/vector')

-- Roams the land
class Wander extends Steering

	theta: math.pi

	new: (entity, @behavior, @radius = 25, @distance = 80, @thetaLimit = math.pi / 8) => super(entity)

	run: (dt) =>
		{ :position, :velocity } = @entity\get()
		if not velocity then velocity = Vector.ZERO

		@theta += math.random(-@thetaLimit, @thetaLimit)

		circlePos = with velocity\clone()
			\normalize()
			\multiply(@distance)
			\add(position)

		h = velocity\getHeading()

		circleOffset = Vector(@radius * math.cos(@theta + h), @radius * math.sin(@theta + h))
		target = circlePos + circleOffset

		@behavior.behavior.target = target
		return @behavior\run(dt)
