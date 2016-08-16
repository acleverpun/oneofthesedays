tactile = require('vendor/tactile/tactile')
Entity = require('lib/entities/entity')
Position = require('lib/components/position')
Drawable = require('lib/components/drawable')
Movable = require('lib/components/movable')
Controllable = require('lib/components/controllable')

class Player extends Entity
	new: (x, y) =>
		super()

		velocity = 200
		width = 50
		height = 50

		@addMultiple({
			Position(x, y),
			Drawable(width, height, { 255, 100, 100 }),
			Movable(velocity),
			Controllable({
				vertical: with tactile.newControl()
					\addButtonPair(tactile.keys('up'), tactile.keys('down'))
					\addButtonPair(tactile.keys('w'), tactile.keys('s'))
					\addButtonPair(tactile.keys('k'), tactile.keys('j'))
				horizontal: with tactile.newControl()
					\addButtonPair(tactile.keys('left'), tactile.keys('right'))
					\addButtonPair(tactile.keys('a'), tactile.keys('d'))
					\addButtonPair(tactile.keys('h'), tactile.keys('l'))
			}),
		})

	control: (dt) =>
		{ :controllable, :movable, :position } = @getAll()
		position.x += movable.velocity * controllable.controls.horizontal() * dt
		position.y += movable.velocity * controllable.controls.vertical() * dt
