System = require('vendor/secs/lib/system')
Vector = require('lib/geo/vector')

wanderTheta = math.pi

class SteeringSystem extends System

	@criteria: System.Criteria({ 'behaviors' })

	update: (dt) =>
		for entity in *@entities
			behaviors = entity\get('behaviors')
			for behavior in *behaviors
				behavior\update(dt)

			-- velocity = @seek(entity, dt)
			-- entity\set('velocity', velocity)

	-- Direct path to target
	naive: (entity, dt, targetPosition) =>
		{ :position, :maxSpeed, :target } = entity\get()
		if not targetPosition then targetPosition = target.position
		return Vector(targetPosition - position, maxSpeed * dt)

	-- Steers toward target
	seek: (entity, dt, targetPosition) =>
		{ :velocity, :maxSpeed, :maxForce, :target } = entity\get()
		if not velocity then velocity = Vector.ZERO
		if not targetPosition then targetPosition = target.position

		desiredVelocity = @naive(entity, dt, targetPosition)
		steering = desiredVelocity - velocity
		steering = steering\truncate(maxForce)
		velocity = (velocity + steering)\truncate(maxSpeed)
		return velocity

	-- Steers away from target
	flee: (entity, dt, targetPosition) =>
		{ :position, :velocity, :maxSpeed, :target, :maxForce } = entity\get()
		if not velocity then velocity = Vector.ZERO
		if not targetPosition then targetPosition = target.position

		desiredVelocity = -@naive(entity, dt, targetPosition)
		steering = desiredVelocity - velocity
		steering = steering\truncate(maxForce)
		velocity = (velocity + steering)\truncate(maxSpeed)
		return velocity

	-- Arrives at target
	arrive: (entity, dt, targetPosition) =>
		{ :position, :velocity, :maxSpeed, :target, :maxForce, :slowingRadius } = entity\get()
		if not velocity then velocity = Vector.ZERO
		if not targetPosition then targetPosition = target.position

		desiredVelocity = targetPosition - position
		distance = desiredVelocity\getLength()

		maxSpeed *= dt
		if distance < slowingRadius
			desiredVelocity = Vector(desiredVelocity, maxSpeed * distance / slowingRadius * dt)
		else
			desiredVelocity = Vector(desiredVelocity, maxSpeed * dt)

		steering = desiredVelocity - velocity
		velocity = (velocity + steering)\truncate(maxSpeed * dt)
		return velocity

	wander: (entity, dt, targetPosition) =>
		{ :position, :velocity, :maxSpeed, :maxForce, :slowingRadius } = entity\get()
		if not velocity then velocity = Vector.ZERO

		wanderR = 25
		wanderD = 80
		change = 0.3
		wanderTheta += math.random(-change, change)

		circlePos = with velocity\clone()
			\normalize()
			\multiply(wanderD)
			\add(position)

		h = velocity\getHeading()

		circleOffset = Vector(wanderR * math.cos(wanderTheta + h), wanderR * math.sin(wanderTheta + h))
		targetPosition = circlePos + circleOffset

		return @seek(entity, dt, targetPosition)
