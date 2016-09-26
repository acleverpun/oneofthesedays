Caste = require('vendor/caste/lib/caste')

class Vector extends Caste

	-- Return vector of specified length
	@normalize: (vector, length = 1) =>
		normalized = vector / vector\getLength()
		if length != 1 then normalized *= length
		return normalized

	new: (x, y) =>
		-- @param {Vector}
		-- @param {Number}
		if @is(x)
			x = @@normalize(x, y)
			y = nil

		if _.isTable(x)
			if x.x or x.y
				-- @param {Table{/(x|y)/ => Number}}
				@x = x.x
				@y = x.y
			elseif x[1] or x[2]
				-- @param {Array{Number}}
				@x = x[1]
				@y = x[2]
		else
			-- @param {Number}
			-- @param {Number}
			@x = x
			@y = y

	getLength: () => math.sqrt(@x^2 + @y^2)

	normalize: (length) =>
		normalized = @@normalize(@, length)
		@x = normalized.x
		@y = normalized.y

	clone: () => @@(@x, @y)

	__tostring: () => "#{@@name}(#{@x}, #{@y})##{@getLength()}"
	toTuple: () => @x, @y
	toArray: () => { @x, @y }
	toTable: () => { x: @x, y: @y, length: @getLength() }

	__eq: (other) => @x == other.x and @y == other.y
	__le: (other) => @x <= other.x and @y <= other.y
	__lt: (other) => (@x < other.x and @y <= other.y) or (@x <= other.x and @y < other.y)

	__unm: () => @@(-@x, -@y)
	__add: (other) => @@(@x + other.x, @y + other.y)
	__sub: (other) => @@(@x - other.x, @y - other.y)
	__mul: (other) =>
		if _.isNumber(other) then return @@(@x * other, @y * other)
		-- dot product
		return @x * other.x + @y * other.y
	__div: (other) =>
		if _.isNumber(other) then return @@(@x / other, @y / other)
		-- cross product
		-- TODO
