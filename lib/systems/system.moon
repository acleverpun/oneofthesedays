Class = require('lib/class')

class System extends Class

	events: nil
	requirements: {}

	new: () =>
		@entities = {}
		@active = true

	add: (entity) =>
		if not entity.id then error 'Added entity has no id.'

		@entities[entity.id] = entity
		if @events then @events\fireEvent('system.entity.added', @, entity)

	remove: (entity) =>
		if not entity.id then error 'Added entity has no id.'

		@entities[entity.id] = nil
		if @events then @events\fireEvent('system.entity.removed', @, entity)

	toggleActive: (...) =>
		isActive = super(...)
		if isActive and _.isFunction(@onEnable) then @onEnable()
		elseif not isActive and _.isFunction(@onDisable) then @onDisable()
		if _.isFunction(@onToggle) then @onToggle(isActive)
