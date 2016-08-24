Enum = require('lib/enums/enum')

class Direction extends Enum
	@NORTH = Direction('NORTH')
	@SOUTH = Direction('SOUTH')
	@EAST = Direction('EAST')
	@WEST = Direction('WEST')

	new: (@value) =>

	__unm: () =>
		if @value == 'NORTH' then return @@SOUTH
		if @value == 'SOUTH' then return @@NORTH
		if @value == 'EAST' then return @@WEST
		if @value == 'WEST' then return @@EAST
