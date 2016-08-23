class Point
	new: (x, y) =>
		if x and y
			@x = x
			@y = y
		elseif not y
			if _.isTable(x)
				if x.x then @x = x.x
				elseif x[1] then @x = x[1]
				if x.y then @y = x.y
				elseif x[2] then @y = x[2]
		else
			@x = 0
			@y = 0

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
