Enum = require('lib/utils/enum')
Direction = require('lib/geo/direction')

Enum({
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
