tactile = require('vendor/tactile/tactile')
Entity = require('lib/entities/entity')
Point = require('lib/geo/point')
Vector = require('lib/geo/vector')
Shape = require('lib/geo/shape')
AnimatedSprite = require('lib/display/sprite')
Movable = require('lib/components/movable')
Controllable = require('lib/input/controllable')
Direction = require('lib/geo/direction')

class Player extends Entity
	new: (...) =>
		super(...)

		speed = 100
		runSpeed = speed * 8

		@addMultiple({
			position: Point(@data.x, @data.y),
			Shape(@data.width, @data.height),
			AnimatedSprite('ff4-characters.png', Vector(47, 5), Shape(16, 16)),
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
		{ :width, :height } = @shape
		(@position + (@position + Point(width, height))) / 2

	getData: () =>
		{ :x, :y } = @position
		{ :width, :height } = @shape
		return { :x, :y, :width, :height }

	clone: (scene) =>
		return @@(scene, @getData())

	control: (dt) =>
		{ :controllable, :movable, :position } = @getAll()

		controls = controllable.controls
		speed = movable.speed

		if controls.run\isDown() then speed = movable.runSpeed

		position.x += speed * controls.horizontal() * dt
		position.y += speed * controls.vertical() * dt
		position.x, position.y, cols, num = @scene.world\move(@, position.x, position.y, (other) =>
			if _.isFunction(other.collision) then return 'cross'
			return 'slide'
		)

		for col in *cols
			if col.type == 'cross' and _.isFunction(col.other.collision)
				col.direction = Direction\fromNormal(col.normal)
				col.offset = position - col.other.data
				col.other\collision(@, col)
