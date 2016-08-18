{ Entity: ToysEntity } = require('vendor/lovetoys/lovetoys')
ToysProxy = require('lib/utils/shims/lovetoys-proxy')

class Entity extends ToysProxy(ToysEntity)
	getAll: () =>
		components = @getComponents()
		result = {}

		for key, value in pairs(components)
			first = string.lower(string.sub(key, 1, 1))
			rest = string.sub(key, 2)
			lowerKey = "#{first}#{rest}"
			result[lowerKey] = value

		return result
