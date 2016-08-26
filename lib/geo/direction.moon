Enum = require('lib/utils/enum')
Vector = require('lib/geo/vector')

class Direction extends Enum
	@fromNormal: (normal) =>
		if normal.x == 0 and normal.y == -1 then return @NORTH
		if normal.x == 0 and normal.y == 1 then return @SOUTH
		if normal.x == -1 and normal.y == 0 then return @WEST
		if normal.x == 1 and normal.y == 0 then return @EAST
		if normal.x == -1 and normal.y == -1 then return @NORTH_WEST
		if normal.x == 1 and normal.y == -1 then return @NORTH_EAST
		if normal.x == -1 and normal.y == 1 then return @SOUTH_WEST
		if normal.x == 1 and normal.y == 1 then return @SOUTH_EAST
		assert(false)

	new: (@value) =>

	toVector: () =>
		if @ == @@NORTH then return Vector(0, 1)
		if @ == @@SOUTH then return Vector(0, -1)
		if @ == @@WEST then return Vector(-1, 0)
		if @ == @@EAST then return Vector(1, 0)
		if @ == @@NORTH_WEST then return Vector(-1, 1)
		if @ == @@NORTH_EAST then return Vector(1, 1)
		if @ == @@SOUTH_WEST then return Vector(-1, -1)
		if @ == @@SOUTH_EAST then return Vector(1, -1)

	__tostring: () => @value

	__unm: () =>
		if @ == @@NORTH then return @@SOUTH
		if @ == @@SOUTH then return @@NORTH
		if @ == @@WEST then return @@EAST
		if @ == @@EAST then return @@WEST

Direction\add({
	'NORTH',
	'SOUTH',
	'WEST',
	'EAST',
	'NORTH_WEST',
	'NORTH_EAST',
	'SOUTH_WEST',
	'SOUTH_EAST',
	NONE: nil
})

return Direction
