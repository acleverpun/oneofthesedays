Entity = require('lib/entities/entity')
Vector = require('lib/geo/vector')
Shape = require('lib/geo/shape')
Animation = require('lib/display/animation')
AnimationList = require('lib/display/animation-list')
Direct = require('lib/behaviors/steering/direct')
Seek = require('lib/behaviors/steering/seek')
Flee = require('lib/behaviors/steering/flee')
Arrive = require('lib/behaviors/steering/arrive')

class Npc extends Entity

	new: (...) =>
		super(...)

		@addMultiple({
			maxSpeed: 50,
			behaviors: {
				-- Direct(@, @scene.player.position)
				-- Seek(@, Direct(@, @scene.player.position))
				-- Flee(@, Direct(@, @scene.player.position))
				Arrive(@, @scene.player.position, 100)
			},
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
