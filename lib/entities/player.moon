tactile = require('vendor/tactile/tactile')
Entity = require('lib/entities/entity')
Point = require('lib/geo/point')
Position = require('lib/components/position')
Drawable = require('lib/components/drawable')
Movable = require('lib/components/movable')
Controllable = require('lib/components/controllable')

class Player extends Entity
	new: (...) =>
		super(...)

		speed = 100
		runSpeed = speed * 8

		@addMultiple({
			Position(Point(@data.x, @data.y)),
			Drawable(@data.width, @data.height, { 255, 100, 100 }),
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

	getData: () =>
		{ :x, :y } = @get('Position').point
		{ :width, :height } = @get('Drawable')
		return { :x, :y, :width, :height }

	clone: (state) =>
		return @@(state, @getData())

	control: (dt) =>
		{ :controllable, :movable, :position } = @getAll()

		controls = controllable.controls
		speed = movable.speed

		if controls.run\isDown() then speed = movable.runSpeed

		point = position.point
		point.x += speed * controls.horizontal() * dt
		point.y += speed * controls.vertical() * dt
		point.x, point.y, cols, num = @state.world\move(@, point.x, point.y, (other) =>
			if _.isFunction(other.onTouch) then return 'cross'
			return 'slide'
		)

		if num > 0
			for { :other, :type } in *cols
				if type == 'cross' and _.isFunction(other.onTouch)
					other\onTouch(@)
