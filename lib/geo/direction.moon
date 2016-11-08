Vector = require('lib/geo/vector')
moon = require('moon')
Enum = require('lib/utils/enum')

class Direction extends Vector

	@headings: { 'EAST', 'SOUTH_EAST', 'SOUTH', 'SOUTH_WEST', 'WEST', 'NORTH_WEST', 'NORTH', 'NORTH_EAST' }

	---
	-- Gets the closest heading for a vector
	--
	-- @method getHeadingName
	-- @static
	-- @param {Vector} vector
	-- @param {Boolean} [allowIntermediate=false] - Whether to return intermediate headings
	-- @return {StdDirection}
	--
	@getHeadingName: (vector, allowIntermediate = false) =>
		if not vector or vector.x == 0 and vector.y == 0 then return 'NONE'
		angle = math.atan2(vector.y, vector.x)
		octants = if allowIntermediate then 8 else 4
		octant = _.round(octants * angle / (2 * math.pi) + octants) % octants
		if octants == 4 then octant *= 2
		octant += 1
		return @headings[octant]

	---
	-- Aligns a vector to the closest standard heading
	--
	-- @method align
	-- @static
	-- @param {Vector} vector
	-- @param {Boolean} [allowIntermediate=false] - Whether to return intermediate headings
	-- @return {Vector} - A new vector with the same magnitude, but aligned to a standard direction
	--
	@align: (vector, allowIntermediate = false) =>
		heading = @getHeadingName(vector, allowIntermediate)
		return Vector(@[heading], #vector)

	---
	-- Returns whether a vector is a standard direction
	--
	-- @method isStandard
	-- @static
	-- @param {Vector} vector
	-- @return {Boolean}
	--
	@isStandard: (vector) =>
		x = math.abs(vector.x)
		y = math.abs(vector.y)
		return (x == 1 or x == 0) and (y == 1 or y == 0)

	new: (x, y) =>
		-- @param {String}
		if _.isString(x)
			direction = @@[x]
			x = direction.x
			y = direction.y

		-- @param {Vector}
		if _.isTable(x) then y = 1

		super(x, y)

		length = #@
		if length != 0 and length != 1 then @normalize()

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
