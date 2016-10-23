Steering = require('lib/behaviors/steering/steering')
Vector = require('lib/geo/vector')
Seek = require('lib/behaviors/steering/seek')

-- Roams the land
class Wander extends Steering

	theta: love.math.random() * math.tau

	new: (entity, @behavior = Seek(entity), @radius = 25, @distance = 80, @thetaLimit = math.pi / 8) => super(entity)

	setTarget: (target) => @behavior\setTarget(target)

	run: (dt) =>
		{ :position, :velocity } = @entity\get()
		if not velocity then velocity = Vector.ZERO

		@theta += love.math.random() * @thetaLimit - 0.5 * @thetaLimit

		circlePos = with velocity\clone()
			\normalize()
			\multiply(@distance)
			\add(position)

		h = velocity\getHeading()

		circleOffset = Vector(@radius * math.cos(@theta + h), @radius * math.sin(@theta + h))
		target = circlePos + circleOffset

		@setTarget(target)
		return @behavior\run(dt)
