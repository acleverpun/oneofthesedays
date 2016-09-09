{ Entity: ToysEntity } = require('vendor/lovetoys/lovetoys')
ToysProxy = require('lib/utils/shims/lovetoys-proxy')
Shape = require('lib/geo/shape')
Point = require('lib/geo/point')
Direction = require('lib/geo/direction')

class Entity extends ToysProxy(ToysEntity)

	new: (@scene, @data) =>
		-- Add components
		@add("is#{@@name}", true) -- identity
		@add('position', Point(@data.x, @data.y))
		@add(Shape(@data.width, @data.height))

	add: (key, component) =>
		if not component
			component = key
			key = component.type
		if @[key] then error 'Entity already has component.'
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

		error 'Point could not be determined.'

	getCenter: () =>
		{ :width, :height } = @shape
		(@position + (@position + Point(width, height))) / 2

	getData: () =>
		{ :x, :y } = @position
		{ :width, :height } = @shape
		return { :x, :y, :width, :height }

	clone: (scene) => return @@(scene, @getData())
