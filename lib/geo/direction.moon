Enum = require('lib/utils/enum')
Vector = require('lib/geo/vector')

class Direction extends Enum

	@fromVector: (vector) =>
		if direction = @[vector] then return direction
		for value in *@values
			if vector == value then return @[value]
		-- TODO: calculate from vector(s)

	@fromNormal: (normal) =>
		if normal.x == 0 and normal.y == -1 then return @NORTH
		if normal.x == 0 and normal.y == 1 then return @SOUTH
		if normal.x == -1 and normal.y == 0 then return @WEST
		if normal.x == 1 and normal.y == 0 then return @EAST
		assert false

	toVector: () => return @value

	__tostring: () => @value

	__unm: () => return @@[-@value]

Direction\add({
	NORTH: Vector(0, 1),
	SOUTH: Vector(0, -1),
	WEST: Vector(-1, 0),
	EAST: Vector(1, 0),
	NORTH_WEST: Vector(-1, 1),
	NORTH_EAST: Vector(1, 1),
	SOUTH_WEST: Vector(-1, -1),
	SOUTH_EAST: Vector(1, -1),
	NONE: nil
})

return Direction
