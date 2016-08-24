tactile = require('vendor/tactile/tactile')
Entity = require('lib/entities/entity')
Point = require('lib/geo/point')
Position = require('lib/components/position')
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
			Position(Point(@data.x, @data.y)),
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

	getPoint: () => @position.point
	getCenter: () =>
		{ :width, :height } = @drawable
		p width, height
		(@getPoint() + (@getPoint() + Point(width, height))) / 2

	getData: () =>
		{ :x, :y } = @getPoint()
		{ :width, :height } = @drawable
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
			if _.isFunction(other.collision) then return 'cross'
			return 'slide'
		)

		for col in *cols
			if col.type == 'cross' and _.isFunction(col.other.collision)
				col.other\collision(@, col)
