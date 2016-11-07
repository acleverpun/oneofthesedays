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
				_.push(entity.commandQueue, UseCommand(entity, @map))

			if controls.attack\pressed()
				_.push(entity.commandQueue, AttackCommand())
