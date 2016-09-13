Class = require('lib/class')
EventManager = require('lib/event-manager')

class Secs extends Class

	new: () =>
		@entities = {}
		@events = EventManager()
		@systems = {}

		@events\addListener('entity.component.added', @, @onComponentAdded)
		@events\addListener('entity.component.removed', @, @onComponentRemoved)

	addSystem: (system) =>
		system.events = @events
		@systems[system.type] = system

		for id, entity in pairs(@entities)
			hasAllReqs = true
			for req in *system.requirements
				if not entity.has(req)
					hasAllReqs = false
					break
			if hasAllReqs then system\add(entity)

	removeSystem: (system) =>
		system.events = nil
		@systems[system.type] = nil

	addEntity: (entity) =>
		entity.events = @events
		entity.id = #@entities + 1
		@entities[entity.id] = entity

		for name, system in pairs(@systems)
			hasAllReqs = true
			for req in *system.requirements
				if not entity.has(req)
					hasAllReqs = false
					break
			if hasAllReqs then system\add(entity)

	removeEntity: (entity) =>
		@entities[entity.id].events = nil
		@entities[entity.id] = nil

	update: (dt) =>
		for name, system in pairs(@systems)
			if system.update then system\update(dt)

	draw: () =>
		for name, system in pairs(@systems)
			if system.draw then system\draw()

	onComponentAdded: () =>
	onComponentRemoved: () =>
