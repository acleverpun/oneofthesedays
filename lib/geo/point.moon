class Point
	new: (x, y = 0) =>
		value = x
		if not _.isNumber(value) then x = 0

		if _.isArray(x)
			@x = x[1]
			@y = x[2]
		elseif _.isTable(x)
			@x = x.x
			@y = x.y
		else
			@x = x
			@y = y

		@[1] = @x
		@[2] = @y

	__tostring: () => "Point(#{@x}, #{@y})"

	__eq: (other) => @x == other.x and @y == other.y
	__le: (other) => @x <= other.x and @y <= other.y
	__lt: (other) => (@x < other.x and @y <= other.y) or (@x <= other.x and @y < other.y)

	__add: (other) => @@(@x + other.x, @y + other.y)
	__sub: (other) => @@(@x - other.x, @y - other.y)
	__mul: (other) =>
		if _.isNumber(other) then return @@(@x * other, @y * other)
		-- dot product
		@x * other.x + @y * other.y
	__div: (other) =>
		if _.isNumber(other) then return @@(@x / other, @y / other)
		-- cross product
		-- TODO
	__unm: () => @@(-@x, -@y)
