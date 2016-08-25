Point = require('lib/geo/point')

class Vector extends Point
	new: (x, y, @origin) =>
		super(x, y)

	toPoint: () => Point(@)

	__tostring: () => "Vector(#{@x}, #{@y})"
