Entity = require('lib/entities/entity')
Vector = require('lib/geo/vector')
Shape = require('lib/geo/shape')
Animation = require('lib/display/animation')
AnimationList = require('lib/display/animation-list')
Input = require('lib/input/input')
Queue = require('lib/utils/queue')

class Player extends Entity

	new: (...) =>
		super(...)

		maxSpeed = 100
		runSpeed = maxSpeed * 2

		@addMultiple({
			:maxSpeed,
			:runSpeed,
			commandQueue: Queue(),
			Input({
				left: { 'key:left', 'key:a', 'key:h', 'axis:leftx-', 'button:dpleft' },
				right: { 'key:right', 'key:d', 'key:l', 'axis:leftx+', 'button:dpright' },
				up: { 'key:up', 'key:w', 'key:k', 'axis:lefty-', 'button:dpup' },
				down: { 'key:down', 'key:s', 'key:j', 'axis:lefty+', 'button:dpdown' },
				run: { 'key:lshift', 'key:rshift', 'button:b' },
				attack: { 'key:space', 'button:a' },
				use: { 'key:return', 'button:x' }
			}),
			AnimationList(@, {
				default: Animation({ 1, 1 }, { duration: 2 }),
				NORTH: Animation({ '5-6', 1 }),
				SOUTH: Animation({ '1-2', 1 }),
				WEST: Animation({ '3-4', 1 }),
				EAST: Animation({ '7-8', 1 }, { offset: Vector(45, 4) }),
			}, {
				image: 'ff4-characters.png',
				shape: Shape(16, 16),
				offset: Vector(46, 4),
				border: 1,
				duration: 0.2
			})
		})
