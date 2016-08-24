{ Entity: ToysEntity } = require('vendor/lovetoys/lovetoys')
ToysProxy = require('lib/utils/shims/lovetoys-proxy')

class Entity extends ToysProxy(ToysEntity)
	new: (@state, @data) =>
		super()

	add: (key, component) =>
		if not component
			component = key
			key = component.type

		assert(not @[key])
		@[key] = component
		super(component)

	addMultiple: (components) =>
		if _.isArray(components)
			for component in *components
				@add(component)
		elseif _.isPlainTable(components)
			for key, component in pairs(components)
				@add(key, component)
		else
			super(components)

	getAll: () =>
		components = @getComponents()
		result = {}

		for key, value in pairs(components)
			result[_.lowerFirst(key)] = value

		return result
