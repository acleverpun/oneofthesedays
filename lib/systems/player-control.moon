System = require('lib/systems/system')
Direction = require('lib/geo/direction')

class PlayerControlSystem extends System

	update: (dt) =>
		for entity in *@getTargets()
			{ :controls, :movable, :position } = entity\getComponents()

			speed = movable.speed
			if controls.run\isDown() then speed = movable.runSpeed

			horizontal = controls.horizontal()
			vertical = controls.vertical()
			if horizontal != 0 or vertical != 0
				movable.goal = position\clone()
				movable.goal.x += speed * horizontal * dt
				movable.goal.y += speed * vertical * dt

			if controls.use\pressed() and movable.collisions
				for col in *movable.collisions
					if col.type == 'slide' and _.isFunction(col.other.onUse)
						useDirection = -Direction\fromVector(col.normal)
						if entity.direction == useDirection
							col.other\onUse(entity, col)

	requires: () => { 'isPlayer', 'controls', 'movable', 'position' }
