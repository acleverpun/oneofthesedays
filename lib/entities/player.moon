tactile = require('vendor/tactile/tactile')
Entity = require('lib/entities/entity')
Vector = require('lib/geo/vector')
Shape = require('lib/geo/shape')
Animation = require('lib/display/animation')
AnimationList = require('lib/display/animation-list')
Speed = require('lib/physics/speed')
Controls = require('lib/input/controls')

class Player extends Entity

	new: (...) =>
		super(...)

		maxSpeed = 100
		runSpeed = maxSpeed * 2

		@addMultiple({
			Speed(maxSpeed, runSpeed)
			Controls({
				vertical: with tactile.newControl()
					\addButtonPair(tactile.keys('up'), tactile.keys('down'))
					\addButtonPair(tactile.keys('w'), tactile.keys('s'))
					\addButtonPair(tactile.keys('k'), tactile.keys('j'))
				horizontal: with tactile.newControl()
					\addButtonPair(tactile.keys('left'), tactile.keys('right'))
					\addButtonPair(tactile.keys('a'), tactile.keys('d'))
					\addButtonPair(tactile.keys('h'), tactile.keys('l'))
				run: with tactile.newControl()
					\addButton(tactile.keys('lshift', 'rshift'))
				attack: with tactile.newControl()
					\addButton(tactile.keys('space'))
				use: with tactile.newControl()
					\addButton(tactile.keys('return'))
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
				duration: 0.2,
			}),
		})
