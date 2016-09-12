Class = require('lib/class')
EventManager = require('lib/event-manager')

class Engine extends Class

	new: () =>
		@entities = {}
		@singleRequirements = {}
		@allRequirements = {}
		@entityLists = {}
		@events = EventManager()

		@systemRegistry = {}
		@systems = {}
		@systems.update = {}
		@systems.draw = {}

		@events\addListener('entity.component.added', @, @onComponentAdded)
		@events\addListener('entity.component.removed', @, @onComponentRemoved)

	addEntity: (entity) =>
		entity.events = @events
		entity.id = #@entities + 1
		@entities[entity.id] = entity

		for key, component in pairs(entity.components)
			if not @entityLists[key] then @entityLists[key] = {}
			@entityLists[key][entity.id] = entity

			if @singleRequirements[key]
				for _, system in pairs(@singleRequirements[key])
					if system\validate(entity) then system\add(entity)

	removeEntity: (entity) =>

	addSystem: (entity) =>

	onComponentAdded: () =>
	onComponentRemoved: () =>
