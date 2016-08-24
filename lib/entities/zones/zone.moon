bump = require('vendor/bump/bump')
Entity = require('lib/entities/entity')
Point = require('lib/geo/point')

class Zone extends Entity
	new: (...) =>
		super(...)
		@add(Point(@data.x, @data.y))

		@entities = {}

	isEntityWithin: (entity) =>
		bump.rect.containsPoint(@data.x, @data.y, @data.width, @data.height, entity\getCenter()\toTuple())

	collision: (entity, collision) =>
		-- TODO: Why is all this collision handling here? Where should it be?
		if not collision.overlaps then return @onTouch(entity, collision)
		if @isEntityWithin(entity)
			@onWithin(entity, collision)

			if not @entities[entity]
				@entities[entity] = entity\getPoint()
				return @onEnter(entity, collision)
		else
			if @entities[entity]
				@entities[entity] = nil
				return @onExit(entity, collision)

	onTouch: (entity, collision) => p 'zone.touch'
	onEnter: (entity, collision) => p 'zone.enter'
	onWithin: (entity, collision) => p 'zone.within'
	onLand: (entity, collision) => p 'zone.land'
	onExit: (entity, collision) => p 'zone.exit'
	onCross: (entity, collision) => p 'zone.cross'
