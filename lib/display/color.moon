TupleStruct = require('lib/utils/structs/tuple-struct')

class Color extends TupleStruct

	new: (r, g = 0, b = 0, a = 255) =>
		value = r
		if not _.isNumber(value) then r = 0

		if _.isArray(value)
			@r = value.r or r
			@g = value.g or g
			@b = value.b or b
			@a = value.a or a
		elseif _.isTable(value)
			@r = value[1] or r
			@g = value[2] or g
			@b = value[3] or b
			@a = value[4] or a
		else
			@r = r
			@g = g
			@b = b
			@a = a

		@[1] = @r
		@[2] = @g
		@[3] = @b
		@[4] = @a

	toTuple: () => @r, @g, @b, @a
	toArray: () => { @r, @g, @b, @a }
	toTable: () => { r: @r, g: @g, b: @b, a: @a }

	__tostring: () => "Color(#{@r}, #{@g}, #{@b}, #{@a})"

	__eq: (other) => @r == other.r and @g == other.g and @b == other.b and @a == other.a

	__add: (other) => @@(@r + other.r, @g + other.g, @b + other.b, @a + other.a)
	__sub: (other) => @@(@r - other.r, @g - other.g, @b - other.b, @a - other.a)
