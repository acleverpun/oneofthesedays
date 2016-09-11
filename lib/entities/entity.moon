Class = require('lib/class')

class Entity extends Class

	events: nil

	new: (components) =>
		@components = {}
		@addMultiple(components)

	set: (key, component) =>
		unless component
			component = key
			key = component.type

		isNew = not @components[key]
		@components[key] = component
		-- TODO: Make getter, rather than duplicate
		@[key] = component

		if isNew and @events then @events\fireEvent('entity.component.added', @, key)

	add: (key, component) =>
		unless component
			component = key
			key = component.type

		if @has(key) then error "Entity already has component '#{key}'."
		if @[key] then error "Entity already has property '#{key}'."

		@set(key, component)

	addMultiple: (components = {}) =>
		for key, component in pairs(components)
			if _.isNumber(key)
				@add(component)
			else
				@add(key, component)

	remove: (key) =>
		if not @has(key) then error "Tried removing nonexistent component '#{key}' from entity."

		@componets[key] = nil
		@[key] = nil
		if @events then @events\fireEvent('entity.component.removed', @, key)

	has: (key) => not not @components[key]
	get: (key) => @components[key]
	getAll: () => @components
