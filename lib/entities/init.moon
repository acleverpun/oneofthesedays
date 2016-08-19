entities = {}

setmetatable(entities, {
	__index: (type) =>
		file = _.kebabCase(type)
		entity = require("lib/entities/#{file}")
		entities[type] = entity
		return entity
})

return entities
