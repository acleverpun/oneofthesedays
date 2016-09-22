Entity = require('vendor/secs/lib/entity')
Shape = require('lib/geo/shape')
Vector = require('lib/geo/vector')
Direction = require('lib/geo/direction')

class MyEntity extends Entity

	new: (@scene, @data) =>
		super({
			["is#{@@name}"]: true,
			position: Vector(@data),
			Shape(@data)
		})

	-- TODO: move to Vector class? Or somewhere? wtf even is it
	-- TODO: rename.exe
	getPoint: (direction) =>
		if not direction then return @position

		{ :x, :y } = @position
		{ :width, :height } = @data

		if direction == Direction.NORTH then return Vector(nil, y)
		if direction == Direction.SOUTH then return Vector(nil, y + height)
		if direction == Direction.EAST then return Vector(x + width, nil)
		if direction == Direction.WEST then return Vector(x, nil)

		assert false

	getCenter: () =>
		{ :width, :height } = @shape
		(@position + (@position + Vector(width, height))) / 2

	getData: () =>
		{ :x, :y } = @position
		{ :width, :height } = @shape
		return { :x, :y, :width, :height }

	clone: (scene) => return @@(scene, @getData())
