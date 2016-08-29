System = require('lib/systems/system')

class ControlSystem extends System

	update: (dt) =>
		for entity in *@getTargets()
			{ :controllable } = entity\getAll()

			for name, control in pairs(controllable.controls)
				control\update(dt)

			entity\control(dt)

	requires: () => { 'controllable' }
