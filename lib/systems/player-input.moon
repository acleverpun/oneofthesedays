System = require('vendor/secs/lib/system')
Vector = require('lib/geo/vector')
UseCommand = require('lib/commands/use')
AttackCommand = require('lib/commands/attack')

class PlayerInputSystem extends System

	@criteria: System.Criteria({ 'isPlayer', 'input', 'position', 'animation', 'maxSpeed' })

	new: (@map) =>

	update: (dt) =>
		for entity in *@entities
			{ :input, :velocity, :position, :animation, :maxSpeed, :runSpeed, :heading } = entity\get()
			if not velocity then velocity = Vector.ZERO

			useCmd = entity.cache.useCmd or UseCommand(entity, @map)
			attackCmd = entity.cache.attackCmd or AttackCommand()

			if input\down('run') then maxSpeed = runSpeed

			horizontal = input\get('right') - input\get('left')
			vertical = input\get('down') - input\get('up')

			if horizontal != 0 or vertical != 0
				velocity = Vector({ horizontal, vertical }, maxSpeed * dt)
				entity\set('velocity', velocity)
				animation.value\resume()
			else
				velocity\reset()
				animation.value\pause()

			if heading and input\pressed('use')
				entity.commandQueue\add(useCmd)

			if input\pressed('attack')
				entity.commandQueue\add(attackCmd)
