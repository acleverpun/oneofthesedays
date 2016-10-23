System = require('vendor/secs/lib/system')

class SteeringSystem extends System

	@criteria: System.Criteria({ 'behaviors' })

	update: (dt) =>
		for entity in *@entities
			behaviors = entity\get('behaviors')
			for behavior in *behaviors
				behavior\update(dt)
