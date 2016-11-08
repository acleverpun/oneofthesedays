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

	__tostring: () => "#{@@name}(#{@x}, #{@y})##{#@}"
	toTuple: () => @x, @y
	toArray: () => { @x, @y }
	toTable: () => { x: @x, y: @y, length: #@ }

	__len: () => math.sqrt(@getLengthSq())

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
		return @dot(value)
	__div: (value) =>
		if _.isNumber(value) then return Vector(@x / value, @y / value)
		-- TODO: cross product (need angle methods)

	add: (value) =>
		if _.isNumber(value)
			@x += value
			@y += value
		else
			@x += value.x
			@y += value.y
		return @

	subtract: (value) =>
		if _.isNumber(value)
			@x -= value
			@y -= value
		else
			@x -= value.x
			@y -= value.y
		return @

	multiply: (value) =>
		if not _.isNumber(value) then error 'lolwut'
		@x *= value
		@y *= value
		return @

	divide: (value) =>
		if not _.isNumber(value) then error 'lolwut'
		@x /= value
		@y /= value
		return @

	equals: (vector) => @x == vector.x and @y == vector.y

	reset: () => @set(0, 0)

	distanceTo: (vector) => math.sqrt((@x - vector.x)^2 + (@y - vector.y)^2)

	dot: (vector) => @x * vector.x + @y * vector.y

	angleTo: (vector) =>
		if (@x == 0 and @y == 0) or (vector.x == 0 and vector.y == 0) then return 0
		dot = @dot(vector)
		amount = dot / (#@ * #vector)
		if amount <= -1 then return math.pi
		if amount >= 1 then return 0
		return math.acos(amount)

	-- Call static methods, and apply result to self
	apply: (method, ...) =>
		vector = @@[method](@@, @, ...)
		@set(vector)
		return @

	rotate: (theta) =>
		oldX = @x
		@x = @x * math.cos(theta) - @y * math.sin(theta)
		@y = oldX * math.sin(theta) + @y * math.cos(theta)
		return @

	-- Normalize vector
	normalize: () =>
		length = #@
		if length != 0 and length != 1 then @divide(length)
		return @

	-- Scale vector to the specified length
	scale: (length = 1) =>
		if #@ == length then return @
		@normalize()
		if length != 1 then @multiply(length)
		return @

	-- Scale vector if bigger than the specified length
	truncate: (length = 1) =>
		if #@ <= length then return @
		@normalize()
		if length != 1 then @multiply(length)
		return @

	clone: () => @@(@x, @y)

	getLength: () => #@
	getLengthSq: () => @x^2 + @y^2
	getPerpendicular: () => @@(-@y, @x)
	getHeading: () => return math.atan2(@y, @x)

	set: (x, y) =>
		if type(x) == 'number'
			@x = x
			@y = y
		else
			@x = x.x
			@y = x.y
		return @

	setAngle: (theta) =>
		length = #@
		@x = math.cos(theta) * length
		@y = math.sin(theta) * length
		return @

moon.mixin(Vector, Enum, {
	ZERO: Vector(0, 0)
})

return Vector
