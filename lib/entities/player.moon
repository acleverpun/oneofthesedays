tactile = require('vendor/tactile/tactile')
Entity = require('lib/entities/entity')
Point = require('lib/geo/point')
Drawable = require('lib/components/drawable')
Movable = require('lib/components/movable')
Controllable = require('lib/components/controllable')
Color = require('lib/display/color')

class Player extends Entity
	new: (...) =>
		super(...)

		speed = 100
		runSpeed = speed * 8

		@addMultiple({
			Point(@data.x, @data.y),
			Drawable(@data.width, @data.height, Color(255, 100, 100)),
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

	getCenter: () =>
		{ :width, :height } = @drawable
		(@point + (@point + Point(width, height))) / 2

	getData: () =>
		{ :x, :y } = @point
		{ :width, :height } = @drawable
		return { :x, :y, :width, :height }

	clone: (state) =>
		return @@(state, @getData())

	control: (dt) =>
		{ :controllable, :movable, :point } = @getAll()

		controls = controllable.controls
		speed = movable.speed

		if controls.run\isDown() then speed = movable.runSpeed

		point.x += speed * controls.horizontal() * dt
		point.y += speed * controls.vertical() * dt
		point.x, point.y, cols, num = @state.world\move(@, point.x, point.y, (other) =>
			if _.isFunction(other.collision) then return 'cross'
			return 'slide'
		)

		for col in *cols
			if col.type == 'cross' and _.isFunction(col.other.collision)
				col.other\collision(@, col)
