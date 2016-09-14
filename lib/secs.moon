Class = require('lib/class')
EventEmitter = require('lib/utils/event-emitter')

class Secs extends Class

	new: () =>
		@entities = {}
		@events = EventEmitter()
		@systems = {}

		if @onComponentAdd then @events\on('entity.component.added', @onComponentAdd)
		if @onComponentRemove then @events\on('entity.component.removed', @onComponentRemove)

	addSystem: (system) =>
		system.active = true
		system.events = @events
		@systems[system.type] = system

		for id, entity in pairs(@entities)
			hasAllReqs = true
			for req in *system.requirements
				if not entity\has(req)
					hasAllReqs = false
					break
			if hasAllReqs then system\add(entity)

		system\init()

	removeSystem: (system) =>
		system.events = nil
		@systems[system.type] = nil

	getSystem: (system) => return @systems[system] or @systems[system.type]
	startSystem: (system) => @toggleSystem(system, true)
	stopSystem: (system) => @toggleSystem(system, false)
	toggleSystem: (system, active) =>
		system = @getSystem(system)
		system.active = if type(active) == 'nil' then not system.active else active

	addEntity: (entity) =>
		entity.events = @events
		entity.id = #@entities + 1
		@entities[entity.id] = entity

		for name, system in pairs(@systems)
			hasAllReqs = true
			for req in *system.requirements
				if not entity\has(req)
					hasAllReqs = false
					break
			if hasAllReqs then system\add(entity)

		entity\init()

	removeEntity: (entity) =>
		@entities[entity.id].events = nil
		@entities[entity.id] = nil

		for name, system in pairs(@systems)
			if system\has(entity) then system\remove(entity)

	update: (dt) =>
		for name, system in pairs(@systems)
			if not system.update or not system.active then continue
			system\update(dt)

	draw: () =>
		for name, system in pairs(@systems)
			if not system.draw or not system.active then continue
			system\draw()
