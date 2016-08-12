{ Entity: ToysEntity } = require('vendor/lovetoys/lovetoys')

class Entity
	new: (parent) =>
		@proxy = ToysEntity(parent)

for key, value in pairs ToysEntity.__instanceDict
	if type(value) == 'function'
		Entity.__base[key] = (...) =>
			@proxy[key](@proxy, ...)

return Entity
