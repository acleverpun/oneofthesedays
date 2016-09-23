Vector = require('lib/geo/vector')

class Direction extends Vector

	new: (x, y) =>
		-- @param {Vector}
		if _.isTable(x) then y = 1

		super(x, y)
		@normalize()

	toVector: () => Vector(@x, @y)
