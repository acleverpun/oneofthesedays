Point = require('lib/geo/point')

class Vector extends Point

	new: (x, y, @origin) => super(x, y)

	toPoint: () => Point(@)

	__tostring: () => "Vector(#{@x}, #{@y})"

	__eq: (other) => @x == other.x and @y == other.y
	__le: (other) => @x <= other.x and @y <= other.y
	__lt: (other) => (@x < other.x and @y <= other.y) or (@x <= other.x and @y < other.y)

	__add: (other) => @@(@x + other.x, @y + other.y)
	__sub: (other) => @@(@x - other.x, @y - other.y)
	__mul: (other) =>
		if _.isNumber(other) then return @@(@x * other, @y * other)
		-- dot product
		@x * other.x + @y * other.y
	__div: (other) =>
		if _.isNumber(other) then return @@(@x / other, @y / other)
		-- cross product
		-- TODO

	__unm: () => @@(-@x, -@y)
