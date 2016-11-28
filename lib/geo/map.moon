Secs = require('vendor/secs/lib/secs')
STI = require('vendor/sti/sti')
bump = require('vendor/bump/bump')
MapLayer = require('lib/geo/map-layer')
{ :Color } = require('vendor/hug/lib/display')

class Map extends Secs

	new: (@id) =>
		super()

		@tiled = STI("assets/maps/#{@id}", { 'bump' })
		@world = bump.newWorld(@tiled.tilewidth)
		@tiled\bump_init(@world)
		@layers = {}

	getTiledLayers: () => @tiled.layers
	getTiledObjects: () => @tiled.objects

	addLayer: (...) =>
		layer = MapLayer(@, ...)
		@layers[layer.name] = layer
		return @

	addSystem: (system, layer) =>
		if type(layer) == 'string' then layer = @layers[layer]
		if layer
			layer\addSystem(system)
		else
			super(system)
		return @

	addEntity: (entity, layer) =>
		{ :position, :shape } = entity\get()
		@world\add(entity, position.x, position.y, shape.width, shape.height)
		if type(layer) == 'string' then layer = @layers[layer]
		if layer
			layer\addEntity(entity)
		else
			super(entity)
		return @

	queryPoint: (point) => @world\queryPoint(point\toTuple())

	update: (dt) =>
		@tiled\update(dt)
		super(dt)

	draw: () =>
		@tiled\draw()
		super()

	setDrawRange: (...) => @tiled\setDrawRange(...)

	drawCollisions: (color = Color(255, 0, 0, 255)) =>
		love.graphics.setColor(color)
		@tiled\bump_draw(@world)
		love.graphics.setColor(Color(255, 255, 255, 255))
