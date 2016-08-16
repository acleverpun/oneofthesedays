System = require('lib/systems/system')

class ControlSystem extends System
	update: (dt) =>
		for entity in *@getTargets()
			{ :controllable, :movable, :position } = entity\getAll()

			for _, control in pairs(controllable.controls)
				control\update()

			position.x += movable.velocity * controllable.controls.horizontal() * dt
			position.y += movable.velocity * controllable.controls.vertical() * dt

	requires: () => { 'Controllable', 'Movable', 'Position' }
