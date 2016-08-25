Enum = require('lib/enums/enum')

class Direction extends Enum
	@NORTH: @('NORTH')
	@SOUTH: @('SOUTH')
	@EAST: @('EAST')
	@WEST: @('WEST')
	@NORTH_EAST: @('NORTH_EAST')
	@NORTH_WEST: @('NORTH_WEST')
	@SOUTH_EAST: @('SOUTH_EAST')
	@SOUTH_WEST: @('SOUTH_WEST')

	@fromNormal: (normal) =>
		if normal.x == 0 and normal.y == -1 then return @NORTH
		if normal.x == 0 and normal.y == 1 then return @SOUTH
		if normal.x == 1 and normal.y == 0 then return @EAST
		if normal.x == -1 and normal.y == 0 then return @WEST
		if normal.x == 1 and normal.y == -1 then return @NORTH_EAST
		if normal.x == -1 and normal.y == -1 then return @NORTH_WEST
		if normal.x == 1 and normal.y == 1 then return @SOUTH_EAST
		if normal.x == -1 and normal.y == 1 then return @SOUTH_WEST
		assert(false)

	new: (@value) =>

	__tostring: () => @value

	__unm: () =>
		if @ == @@NORTH then return @@SOUTH
		if @ == @@SOUTH then return @@NORTH
		if @ == @@EAST then return @@WEST
		if @ == @@WEST then return @@EAST
