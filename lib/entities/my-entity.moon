Entity = require('lib/entities/entity')
Shape = require('lib/geo/shape')
Point = require('lib/geo/point')
Direction = require('lib/geo/direction')

class MyEntity extends Entity

	new: (@scene, @data) =>
		super({
			["is#{@@name}"]: true,
			position: Point(@data.x, @data.y),
			Shape(@data.width, @data.height)
		})

	-- TODO: move to Point class
	getPoint: (direction) =>
		position = @position
		if not position then position = Point(@data)
		if not direction then return position

		{ :x, :y } = position
		{ :width, :height } = @data

		if direction == Direction.NORTH then return Point(nil, y)
		if direction == Direction.SOUTH then return Point(nil, y + height)
		if direction == Direction.EAST then return Point(x + width, nil)
		if direction == Direction.WEST then return Point(x, nil)

		assert false

	getCenter: () =>
		{ :width, :height } = @shape
		(@position + (@position + Point(width, height))) / 2

	getData: () =>
		{ :x, :y } = @position
		{ :width, :height } = @shape
		return { :x, :y, :width, :height }

	clone: (scene) => return @@(scene, @getData())
