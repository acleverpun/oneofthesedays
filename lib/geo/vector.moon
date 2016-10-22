Caste = require('vendor/caste/lib/caste')
moon = require('moon')
Enum = require('lib/utils/enum')

class Vector extends Caste

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
				@scale(y)
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
		return self

	subtract: (value) =>
		if _.isNumber(value)
			@x -= value
			@y -= value
		else
			@x -= value.x
			@y -= value.y
		return self

	multiply: (value) =>
		if not _.isNumber(value) then error 'lolwut'
		@x *= value
		@y *= value
		return self

	divide: (value) =>
		if not _.isNumber(value) then error 'lolwut'
		@x /= value
		@y /= value
		return self

	getLength: () => math.sqrt(@x^2 + @y^2)

	-- Normalize vector
	normalize: () =>
		length = @getLength()
		if length > 0
			@x /= length
			@y /= length
		return self

	-- Scale vector to the specified length
	scale: (length = 1) =>
		if @getLength() == length then return self
		@normalize()
		if length != 1 then @multiply(length)
		return self

	-- Scale vector if bigger than the specified length
	truncate: (length = 1) =>
		if @getLength() <= length then return self
		@normalize()
		if length != 1 then @multiply(length)
		return self

	-- Call static methods, and apply result to self
	apply: (method, ...) =>
		vector = @@[method](@@, @, ...)
		@x = vector.x
		@y = vector.y
		return self

	setAngle: (value) =>
		length = @getLength()
		@x = math.cos(value) * length
		@y = math.sin(value) * length
		return self

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

moon.mixin(Vector, Enum, {
	ZERO: Vector(0, 0)
})

return Vector
