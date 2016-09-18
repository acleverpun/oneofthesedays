System = require('vendor/secs/lib/system')

class ControlSystem extends System

	@criteria: System.Criteria({ 'controls' })

	update: (dt) =>
		for entity in *@entities
			{ :controls } = entity\get()

			for name, control in pairs(controls.list)
				control\update(dt)
