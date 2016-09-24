moon = require('moon')
Enum = require('lib/utils/enum')
Vector = require('lib/geo/vector')

class Direction extends Vector

	new: (x, y) =>
		-- @param {Vector}
		if _.isTable(x) then y = 1

		super(x, y)
		-- @normalize()

	toVector: () => Vector(@x, @y)

moon.mixin(Direction, Enum, {
	NORTH: Direction(0, -1),
	SOUTH: Direction(0, 1),
	WEST: Direction(-1, 0),
	EAST: Direction(1, 0),
	NORTH_WEST: Direction(-1, -1),
	NORTH_EAST: Direction(1, -1),
	SOUTH_WEST: Direction(-1, 1),
	SOUTH_EAST: Direction(1, 1),
	NONE: Direction(0, 0)
})

return Direction
