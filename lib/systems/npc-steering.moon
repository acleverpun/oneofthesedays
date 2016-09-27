System = require('vendor/secs/lib/system')
Vector = require('lib/geo/vector')
Direction = require('lib/geo/direction')

class NpcSteeringSystem extends System

	@criteria: System.Criteria({ 'isNpc', 'position', 'speed', 'target' })

	update: (dt) =>
		for entity in *@entities
			{ :position, :speed, :target } = entity\get()

			maxSpeed = speed.value

			velocity = Vector(target.position - position, maxSpeed) * dt
			entity\set('velocity', velocity)
