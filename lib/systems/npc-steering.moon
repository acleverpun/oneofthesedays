System = require('vendor/secs/lib/system')
Vector = require('lib/geo/vector')

class NpcSteeringSystem extends System

	@criteria: System.Criteria({ 'isNpc', 'position', 'maxSpeed', 'maxForce', 'target' })

	update: (dt) =>
		for entity in *@entities
			@seek(entity, dt)

	naive: (entity, dt) =>
		{ :position, :maxSpeed, :target } = entity\get()
		velocity = Vector(target.position - position, maxSpeed) * dt
		entity\set('velocity', velocity)

	seek: (entity, dt) =>
		{ :position, :velocity, :maxSpeed, :target, :maxForce } = entity\get()
		desiredVelocity = Vector(target.position - position, maxSpeed) * dt
		if not velocity then velocity = Vector.ZERO
		steering = desiredVelocity - velocity
		steering = Vector\truncate(steering, maxForce)
		velocity = Vector\truncate(velocity + steering, maxSpeed)
		entity\set('velocity', velocity)
