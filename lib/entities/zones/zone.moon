bump = require('vendor/bump/bump')
MyEntity = require('lib/entities/my-entity')
Point = require('lib/geo/point')

class Zone extends MyEntity

	entities: {}

	new: (...) =>
		super(...)
		@add(Point(@data.x, @data.y))

	isEntityWithin: (entity) =>
		bump.rect.containsPoint(@data.x, @data.y, @data.width, @data.height, entity\getCenter()\toTuple())

	collision: (entity, collision) =>
		-- TODO: Why is all this collision handling here? Where should it be?
		if not collision.overlaps then return @onTouch(entity, collision)
		if @isEntityWithin(entity)
			@onWithin(entity, collision)

			if not @entities[entity]
				@entities[entity] = entity.position
				return @onEnter(entity, collision)
		else
			if @entities[entity]
				@entities[entity] = nil
				return @onExit(entity, collision)

	onTouch: (entity, collision) => -- print 'zone.touch'
	onEnter: (entity, collision) => print 'zone.enter'
	onWithin: (entity, collision) => -- print 'zone.within'
	onLand: (entity, collision) => print 'zone.land'
	onExit: (entity, collision) => print 'zone.exit'
	onCross: (entity, collision) => print 'zone.cross'
