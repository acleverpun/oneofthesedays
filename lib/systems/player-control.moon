System = require('vendor/secs/lib/system')
Vector = require('lib/geo/vector')
Direction = require('lib/geo/direction')

class PlayerControlSystem extends System

	@criteria: System.Criteria({ 'isPlayer', 'controls', 'movable', 'position', 'animation' })

	update: (dt) =>
		for entity in *@entities
			{ :controls, :velocity, :movable, :position, :animation, :collisions } = entity\get()

			speed = movable.speed
			if controls.run\isDown() then speed = movable.runSpeed

			horizontal = controls.horizontal()
			vertical = controls.vertical()
			if horizontal != 0 or vertical != 0
				newVelocity = Vector(speed * horizontal * dt, speed * vertical * dt)
				entity\set('velocity', newVelocity)
				animation.value\resume()
			else
				if velocity
					velocity.x = 0
					velocity.y = 0
				animation.value\pause()

			if collisions and controls.use\pressed()
				for col in *collisions
					if col.type == 'slide' and _.isFunction(col.other.onUse)
						if -Direction(col.normal) == Direction(entity.velocity)
							col.other\onUse(entity, col)
