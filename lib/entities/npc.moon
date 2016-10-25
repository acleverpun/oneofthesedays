Entity = require('lib/entities/entity')
Vector = require('lib/geo/vector')
Shape = require('lib/geo/shape')
Animation = require('lib/display/animation')
AnimationList = require('lib/display/animation-list')
Direct = require('lib/behaviors/steering/direct')
Seek = require('lib/behaviors/steering/seek')
Flee = require('lib/behaviors/steering/flee')
Arrive = require('lib/behaviors/steering/arrive')
Wander = require('lib/behaviors/steering/wander')
Pursue = require('lib/behaviors/steering/pursue')

class Npc extends Entity

	new: (...) =>
		super(...)

		@addMultiple({
			target: @scene.player.position,
			maxSpeed: 20,
			-- Sprite('ff4-characters.png', Vector(64, 119), Shape(16, 16))
			AnimationList(@, {
				default: Animation({ 1, 1 }, { duration: 2 }),
				NORTH: Animation({ '5-6', 1 }),
				SOUTH: Animation({ '1-2', 1 }, { offset: Vector(62, 119), border: 2 }),
				WEST: Animation({ '3-4', 1 }, { offset: Vector(65, 119) }),
				EAST: Animation({ '7-8', 1 }),
			}, {
				image: 'ff4-characters.png',
				shape: Shape(16, 16),
				offset: Vector(66, 119),
				border: 1,
				duration: 0.2
			})
		})

		-- NOTE: These are currently added separately because they require a `target`
		@add('behaviors', {
			-- Direct(@)
			-- Seek(@)
			-- Flee(@)
			-- Arrive(@, 100)
			-- Wander(@)
			Pursue(@, @scene.player)
		})
