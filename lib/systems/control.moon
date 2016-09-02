System = require('lib/systems/system')

class ControlSystem extends System

	update: (dt) =>
		for entity in *@getTargets()
			{ :controls } = entity\getAll()

			for name, control in pairs(controls.list)
				control\update(dt)

			entity\control(dt)

	requires: () => { 'controls' }
