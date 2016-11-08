System = require('vendor/secs/lib/system')

class InputSystem extends System

	@criteria: System.Criteria({ 'input' })

	update: (dt) =>
		for entity in *@entities
			entity\get('input')\update(dt)
