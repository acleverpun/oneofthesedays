moon = require('moon')
Enum = require('lib/utils/enum')
Vector = require('lib/geo/vector')

class Direction extends Vector

	new: (x, y) =>
		-- @param {Vector}
		if _.isTable(x) then y = 1

		super(x, y)
		-- @normalize()

	getHeading: (allowIntermediate = false) =>
		if @x == 0 and @y == 0 then return @@NONE
		angle = math.atan2(@y, @x)
		octants = if allowIntermediate then 8 else 4
		octant = _.round(octants * angle / (2 * math.pi) + octants) % octants
		if octants == 4 then octant *= 2
		octant += 1
		return @@headings[octant]

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

Direction.headings = { 'EAST', 'SOUTH_EAST', 'SOUTH', 'SOUTH_WEST', 'WEST', 'NORTH_WEST', 'NORTH', 'NORTH_EAST' }

return Direction
