Caste = require('vendor/caste/lib/caste')

class Vector extends Caste

	@getLength: (vector) => math.sqrt(vector.x^2 + vector.y^2)

	-- Return normalized vector
	@normalize: (vector) =>
		length = @getLength(vector)
		return @(vector.x / length, vector.y / length)

	-- Return vector scaled to a specified length
	@scale: (vector, length = 1) =>
		if @getLength(vector) == length then return vector
		vector = @normalize(vector)
		if length != 1 then vector\multiply(length)
		return vector

	-- Return vector of max length
	@truncate: (vector, length = 1) =>
		if @getLength(vector) <= length then return vector
		vector = @normalize(vector)
		if length != 1 then vector\multiply(length)
		return vector

	new: (x, y) =>
		if _.isTable(x)
			if x.x or x.y
				-- @param {Table{/(x|y)/ => Number}}
				@x = x.x
				@y = x.y
			elseif x[1] or x[2]
				-- @param {Array{Number}}
				@x = x[1]
				@y = x[2]

			-- @param {Vector}
			-- @param {Number}
			if _.isNumber(y)
				@apply('scale', y)
		else
			-- @param {Number}
			-- @param {Number}
			@x = x
			@y = y

	add: (value) =>
		if _.isNumber(value)
			@x += value
			@y += value
		else
			@x += value.x
			@y += value.y

	subtract: (value) =>
		if _.isNumber(value)
			@x -= value
			@y -= value
		else
			@x -= value.x
			@y -= value.y

	multiply: (value) =>
		if not _.isNumber(value) then error 'lolwut'
		@x *= value
		@y *= value

	divide: (value) =>
		if not _.isNumber(value) then error 'lolwut'
		@x /= value
		@y /= value

	getLength: () => math.sqrt(@x^2 + @y^2)

	apply: (method, ...) =>
		vector = @@[method](@@, @, ...)
		@x = vector.x
		@y = vector.y

	clone: () => @@(@x, @y)

	__tostring: () => "#{@@name}(#{@x}, #{@y})##{@getLength()}"
	toTuple: () => @x, @y
	toArray: () => { @x, @y }
	toTable: () => { x: @x, y: @y, length: @getLength() }

	__eq: (value) => @x == value.x and @y == value.y
	__le: (value) => @x <= value.x and @y <= value.y
	__lt: (value) => (@x < value.x and @y <= value.y) or (@x <= value.x and @y < value.y)

	__unm: () => @@(-@x, -@y)
	__add: (value) =>
		if _.isNumber(value) then return Vector(@x + value, @y + value)
		return Vector(@x + value.x, @y + value.y)
	__sub: (value) =>
		if _.isNumber(value) then return Vector(@x - value, @y - value)
		return Vector(@x - value.x, @y - value.y)
	__mul: (value) =>
		if _.isNumber(value) then return Vector(@x * value, @y * value)
		-- dot product
		return @x * value.x + @y * value.y
	__div: (value) =>
		if _.isNumber(value) then return Vector(@x / value, @y / value)
		-- TODO: cross product (need angle methods)
