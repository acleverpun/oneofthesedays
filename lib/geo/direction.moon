Enum = require('lib/utils/enum')
Vector = require('lib/geo/vector')

class Direction extends Enum

	@fromVector: (vector, recurse = false) =>
		if direction = @[vector] then return direction
		for value in *@values
			if vector == value then return @[value]

		if not recurse
			normX = if vector.x == 0 then 1 else math.abs(vector.x)
			normY = if vector.y == 0 then 1 else math.abs(vector.y)
			return @fromVector(Vector(vector.x / normX, vector.y / normY), true)

		return @@NONE

	toVector: () => return @value

	__tostring: () => @key
	__eq: (other) => @key == other.key and @value == other.value
	__add: (other) => @@fromVector(@value + other.value)
	__sub: (other) => @@fromVector(@value - other.value)
	__unm: () => return @@fromVector(-@value)

Direction\add({
	NORTH: Vector(0, -1),
	SOUTH: Vector(0, 1),
	WEST: Vector(-1, 0),
	EAST: Vector(1, 0),
	NORTH_WEST: Vector(-1, -1),
	NORTH_EAST: Vector(1, -1),
	SOUTH_WEST: Vector(-1, 1),
	SOUTH_EAST: Vector(1, 1),
	NONE: Vector(0, 0)
})

return Direction
