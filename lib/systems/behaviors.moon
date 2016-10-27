System = require('vendor/secs/lib/system')

class NpcSystem extends System

	@criteria: System.Criteria({ 'isNpc', 'steering' })

	new: (@scene) =>

	update: (dt) =>
		for entity in *@entities
			entity.steering\init(dt)

			-- entity.steering\direct(entity.target.position)
			-- entity.steering\seek(entity.target.position)
			entity.steering\flee(entity.target.position)
			-- entity.steering\pursue(entity.target)
			-- entity.steering\evade(entity.target)
			entity.steering\wander()

			entity.steering\update(dt)
