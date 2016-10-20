System = require('vendor/secs/lib/system')
Vector = require('lib/geo/vector')

CIRCLE_DISTANCE = 1
CIRCLE_RADIUS = 100
ANGLE_CHANGE = math.pi
wanderAngle = 0

class NpcSteeringSystem extends System

	@criteria: System.Criteria({ 'isNpc', 'position', 'maxSpeed', 'maxForce', 'target' })

	update: (dt) =>
		for entity in *@entities
			velocity = @wander(entity, dt)
			entity\set('velocity', velocity)

	-- Direct path to target
	naive: (entity, dt) =>
		{ :position, :maxSpeed, :target } = entity\get()
		return Vector(target.position - position, maxSpeed * dt)

	-- Steers toward target
	seek: (entity, dt) =>
		{ :position, :velocity, :maxSpeed, :target, :maxForce } = entity\get()
		desiredVelocity = @naive(entity, dt)
		if not velocity then velocity = Vector.ZERO
		steering = desiredVelocity - velocity
		steering = Vector\truncate(steering, maxForce)
		velocity = Vector\truncate(velocity + steering, maxSpeed)
		return velocity

	-- Steers away from target
	flee: (entity, dt) =>
		{ :position, :velocity, :maxSpeed, :target, :maxForce } = entity\get()
		desiredVelocity = -@naive(entity, dt)
		if not velocity then velocity = Vector.ZERO
		steering = desiredVelocity - velocity
		steering = Vector\truncate(steering, maxForce)
		velocity = Vector\truncate(velocity + steering, maxSpeed)
		return velocity

	-- Arrives at target
	arrive: (entity, dt) =>
		{ :position, :velocity, :maxSpeed, :target, :maxForce, :slowingRadius } = entity\get()
		desiredVelocity = target.position - position
		distance = desiredVelocity\getLength()

		maxSpeed *= dt
		if distance < slowingRadius
			desiredVelocity = Vector(desiredVelocity, maxSpeed * distance / slowingRadius * dt)
		else
			desiredVelocity = Vector(desiredVelocity, maxSpeed * dt)

		if not velocity then velocity = Vector.ZERO
		steering = desiredVelocity - velocity
		velocity = Vector\truncate(velocity + steering, maxSpeed * dt)
		return velocity

	wander: (entity, dt) =>
		{ :position, :velocity, :maxSpeed, :target, :maxForce, :slowingRadius } = entity\get()

		if not velocity then velocity = Vector.ZERO
		circleCenter = velocity\clone()
		circleCenter\apply('normalize')
		circleCenter\apply('scale', CIRCLE_DISTANCE)

		displacement = Vector(0, -1)
		displacement\apply('scale', CIRCLE_RADIUS)
		displacement\setAngle(wanderAngle)

		wanderAngle += math.random() * ANGLE_CHANGE - ANGLE_CHANGE * 0.5
		wanderForce = circleCenter + displacement

		steering = wanderForce
		steering = Vector\truncate(steering, maxForce)
		velocity = Vector\truncate(velocity + steering, maxSpeed)
		return velocity
