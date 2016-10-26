System = require('vendor/secs/lib/system')

class NpcSystem extends System

	@criteria: System.Criteria({ 'isNpc', 'steering' })

	new: (@scene) =>

	update: (dt) =>
		for entity in *@entities
			entity.seek\update(dt)
			-- entity.steering\init(dt)
			-- -- entity.velocity\multiply(dt)
			-- entity.steering\direct(@scene.player.position)
			-- -- entity.steering\seek(@scene.player.position)
			-- entity.steering\update(dt)
