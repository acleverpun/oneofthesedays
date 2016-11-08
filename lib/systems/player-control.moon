System = require('vendor/secs/lib/system')
Vector = require('lib/geo/vector')
UseCommand = require('lib/commands/use')
AttackCommand = require('lib/commands/attack')

class PlayerControlSystem extends System

	@criteria: System.Criteria({ 'isPlayer', 'controls', 'position', 'animation', 'maxSpeed' })

	new: (@map) =>

	update: (dt) =>
		for entity in *@entities
			{ :controls, :velocity, :position, :animation, :maxSpeed, :runSpeed, :heading } = entity\get()
			if not velocity then velocity = Vector.ZERO

			useCmd = entity.cache.useCmd or UseCommand(entity, @map)
			attackCmd = entity.cache.attackCmd or AttackCommand()

			if controls.run\isDown() then maxSpeed = runSpeed

			horizontal = controls.horizontal()
			vertical = controls.vertical()
			if horizontal != 0 or vertical != 0
				velocity = Vector({ horizontal, vertical }, maxSpeed * dt)
				entity\set('velocity', velocity)
				animation.value\resume()
			else
				velocity\reset()
				animation.value\pause()

			if heading and controls.use\pressed()
				entity.commandQueue\add(useCmd)

			if controls.attack\pressed()
				entity.commandQueue\add(attackCmd)
