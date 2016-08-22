{ Entity: ToysEntity } = require('vendor/lovetoys/lovetoys')
ToysProxy = require('lib/utils/shims/lovetoys-proxy')

class Entity extends ToysProxy(ToysEntity)
	new: (@state, @tile) =>
		super()

	getAll: () =>
		components = @getComponents()
		result = {}

		for key, value in pairs(components)
			result[_.lowerFirst(key)] = value

		return result
