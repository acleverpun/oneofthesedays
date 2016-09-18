System = require('vendor/secs/lib/system')
Direction = require('lib/geo/direction')

class PlayerControlSystem extends System

	@criteria: System.Criteria({ 'isPlayer', 'controls', 'movable', 'position', 'animation' })

	update: (dt) =>
		for entity in *@entities
			{ :controls, :movable, :position, :animation } = entity\get()

			speed = movable.speed
			if controls.run\isDown() then speed = movable.runSpeed

			horizontal = controls.horizontal()
			vertical = controls.vertical()
			if horizontal != 0 or vertical != 0
				movable.goal = position\clone()
				movable.goal.x += speed * horizontal * dt
				movable.goal.y += speed * vertical * dt
				animation.value\resume()
			else
				animation.value\pause()

			if controls.use\pressed() and movable.collisions
				for col in *movable.collisions
					if col.type == 'slide' and _.isFunction(col.other.onUse)
						useDirection = -Direction\fromVector(col.normal)
						if entity.direction == useDirection
							col.other\onUse(entity, col)
