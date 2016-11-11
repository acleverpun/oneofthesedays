spine = require('vendor/spine-love/spine')
System = require('vendor/secs/lib/system')
Vector = require('lib/geo/vector')
MoveCommand = require('lib/commands/move')
UseCommand = require('lib/commands/use')
AttackCommand = require('lib/commands/attack')

class PlayerInputSystem extends System

	@criteria: System.Criteria({ 'isPlayer', 'input', 'position', 'animation', 'maxSpeed' })

	new: (@map) =>
		@skeletonRenderer = spine.SkeletonRenderer.new()

	update: (dt) =>
		for entity in *@entities
			{ :input, :velocity, :animation, :maxSpeed, :runSpeed, :heading } = entity\get()

			useCmd = entity.cache.useCmd or UseCommand(entity, @map)
			attackCmd = entity.cache.attackCmd or AttackCommand()

			if input\down('run') then maxSpeed = runSpeed

			horizontal = input\get('right') - input\get('left')
			vertical = input\get('down') - input\get('up')

			if horizontal != 0 or vertical != 0
				velocity = Vector({ horizontal, vertical }, maxSpeed * dt)
				entity.commandQueue\add(MoveCommand(entity, velocity))
			else
				if velocity then velocity\reset()
				animation.value\pause()

			if heading and input\pressed('use')
				entity.commandQueue\add(useCmd)

			if input\pressed('attack')
				entity.commandQueue\add(attackCmd)

			{ :state, :skeleton } = entity.skeleton
			state\update(dt)
			state\apply(skeleton)
			skeleton\updateWorldTransform()

	draw: () =>
		for entity in *@entities
			{ :skeleton } = entity.skeleton
			@skeletonRenderer\draw(skeleton)
