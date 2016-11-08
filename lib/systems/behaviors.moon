System = require('vendor/secs/lib/system')

class NpcSystem extends System

	@criteria: System.Criteria({ 'isNpc', 'steering' })

	new: (@scene) =>

	update: (dt) =>
		for entity in *@entities
			entity.steering\init(dt)

			target = entity.target
			targetPosition = target.position

			if #(targetPosition - entity.position) < 100
				-- entity.steering\direct(targetPosition)
				entity.steering\seek(targetPosition)
				-- entity.steering\flee(targetPosition)
				-- entity.steering\pursue(target)
				-- entity.steering\evade(target)
			else
				entity.steering\wander()

			entity.steering\update(dt)
