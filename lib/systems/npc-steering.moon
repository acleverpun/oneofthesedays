System = require('vendor/secs/lib/system')
Vector = require('lib/geo/vector')

class NpcSteeringSystem extends System

	@criteria: System.Criteria({ 'isNpc', 'position', 'maxSpeed', 'maxForce', 'target' })

	update: (dt) =>
		for entity in *@entities
			velocity = @flee(entity, dt)
			entity\set('velocity', velocity)

	-- Direct path to target
	naive: (entity, dt) =>
		{ :position, :maxSpeed, :target } = entity\get()
		return Vector(target.position - position, maxSpeed) * dt

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
