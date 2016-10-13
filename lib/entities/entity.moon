SecsEntity = require('vendor/secs/lib/entity')
Shape = require('lib/geo/shape')
Vector = require('lib/geo/vector')
Direction = require('lib/geo/direction')
Tile = require('lib/geo/tile')

class Entity extends SecsEntity

	new: (@scene, data) =>
		super({
			["is#{@@name}"]: true,
			position: Vector(data),
			Shape(data),
			Tile(data)
		})

	---
	-- Returns a point found on the entity
	--
	-- @method getPoint
	-- @param {StdDirection} [direction] - Use the point at the specified direction.
	-- @return {Point}
	--
	getPoint: (direction) =>
		if not direction then return @position
		if _.isString(direction) then direction = Direction[direction]

		{ :x, :y } = @position
		{ :width, :height } = @shape

		if direction.x == 0 then x = x + width / 2
		elseif direction.x == 1 then x = x + width
		if direction.y == 0 then y = y + height / 2
		elseif direction.y == 1 then y = y + height

		return Vector(x, y)

	getCenter: () =>
		{ :width, :height } = @shape
		(@position + (@position + Vector(width, height))) / 2

	getData: () =>
		{ :x, :y } = @position
		{ :width, :height } = @shape
		return { :x, :y, :width, :height }

	clone: (scene) => return @@(scene, @getData())
