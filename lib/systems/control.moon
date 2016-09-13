System = require('lib/systems/system')

class ControlSystem extends System

	update: (dt) =>
		for entity in *@entities
			{ :controls } = entity\getAll()

			for name, control in pairs(controls.list)
				control\update(dt)

	requires: () => { 'controls' }
