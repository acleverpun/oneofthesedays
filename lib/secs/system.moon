Class = require('lib/class')

class System extends Class

	active: false
	events: nil
	requirements: {}

	init: () =>
		@entities = {}
		if @onAdd then @events\on('system.entity.add', @onAdd, @)
		if @onRemove then @events\on('system.entity.remove', @onRemove, @)

	add: (entity) =>
		if not entity.id then error 'Added entity has no id.'

		@entities[entity.id] = entity
		if @events then @events\emit('system.entity.add', @, entity)

	remove: (entity) =>
		if not entity.id then error 'Added entity has no id.'

		@entities[entity.id] = nil
		if @events then @events\emit('system.entity.remove', @, entity)

	get: (entity) => if entity then @entities[entity] or @entities[entity.id] else @entities
	has: (entity) => not not @get(entity)

	toggleActive: (...) =>
		isActive = super(...)
		if isActive and _.isFunction(@onEnable) then @onEnable()
		elseif not isActive and _.isFunction(@onDisable) then @onDisable()
		if _.isFunction(@onToggle) then @onToggle(isActive)
