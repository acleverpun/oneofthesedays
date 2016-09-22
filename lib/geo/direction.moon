Vector = require('lib/geo/vector')

class Direction extends Vector

	new: (x, y) =>
		-- @param {Vector}
		if Vector\is(x) then y = 1

		super(x, y)
		@normalize()

	__tostring: () => @key
	toVector: () => Vector(@x, @y)
