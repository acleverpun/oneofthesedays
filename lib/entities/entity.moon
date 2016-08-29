{ Entity: ToysEntity } = require('vendor/lovetoys/lovetoys')
ToysProxy = require('lib/utils/shims/lovetoys-proxy')
Point = require('lib/geo/point')
Direction = require('lib/geo/direction')

class Entity extends ToysProxy(ToysEntity)
	new: (@scene, @data) =>
		super()

	add: (key, component) =>
		if not component
			component = key
			key = component.type
		assert(not @[key])
		@[key] = component
		super(component, key)

	set: (key, component) =>
		if not component
			component = key
			key = component.type
		@[key] = component
		super(component, key)

	addMultiple: (components) =>
		for key, component in pairs(components)
			if _.isNumber(key)
				@add(component)
			else
				@add(key, component)

	getAll: () =>
		components = @getComponents()
		result = {}
		for key, value in pairs(components)
			result[_.lowerFirst(key)] = value
		return result

	getPoint: (direction) =>
		position = @position
		if not position then position = Point(@data)
		if not direction then return position

		{ :x, :y } = position
		{ :width, :height } = @data

		if direction == Direction.NORTH then return Point(nil, y)
		if direction == Direction.SOUTH then return Point(nil, y + height)
		if direction == Direction.EAST then return Point(x + width, nil)
		if direction == Direction.WEST then return Point(x, nil)

		assert false
