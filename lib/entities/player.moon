tactile = require('vendor/tactile/tactile')
Entity = require('lib/entities/entity')
Position = require('lib/components/position')
Drawable = require('lib/components/drawable')
Movable = require('lib/components/movable')
Controllable = require('lib/components/controllable')

class Player extends Entity
	new: (x, y) =>
		super()

		speed = 100
		runSpeed = speed * 8
		width = 16
		height = 16

		@addMultiple({
			Position(x, y),
			Drawable(width, height, { 255, 100, 100 }),
			Movable(speed, runSpeed),
			Controllable({
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
		})

	control: (dt) =>
		{ :controllable, :movable, :position } = @getAll()

		controls = controllable.controls
		speed = movable.speed

		if controls.run\isDown() then speed = movable.runSpeed
		position.x += speed * controls.horizontal() * dt
		position.y += speed * controls.vertical() * dt
