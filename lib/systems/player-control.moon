System = require('vendor/secs/lib/system')
Vector = require('lib/geo/vector')
Direction = require('lib/geo/direction')

class PlayerControlSystem extends System

	@criteria: System.Criteria({ 'isPlayer', 'controls', 'position', 'animation', 'maxSpeed' })

	new: (@world) =>

	update: (dt) =>
		for entity in *@entities
			{ :controls, :velocity, :position, :animation, :maxSpeed, :runSpeed, :heading } = entity\get()

			if controls.run\isDown() then maxSpeed = runSpeed

			horizontal = controls.horizontal()
			vertical = controls.vertical()
			if horizontal != 0 or vertical != 0
				newVelocity = Vector({ horizontal, vertical }, maxSpeed) * dt
				entity\set('velocity', newVelocity)
				animation.value\resume()
			else
				if velocity
					velocity.x = 0
					velocity.y = 0
				animation.value\pause()

			if heading and controls.use\pressed()
				direction = Direction[heading]
				point = entity\getPoint(direction) + direction
				items = @world\queryPoint(point.x, point.y)
				for item in *items
					if _.isFunction(item.onUse)
						item\onUse(entity)
