Caste = require('vendor/caste/lib/caste')
STI = require('vendor/sti/sti')
bump = require('vendor/bump/bump')
Color = require('lib/display/color')

class Map extends Caste

	new: (@id) =>
		@tiled = STI("assets/maps/#{@id}", { 'bump' })
		@world = bump.newWorld(@tiled.tilewidth)
		@tiled\bump_init(@world)

	getTiledLayers: () => @tiled.layers
	getTiledObjects: () => @tiled.objects

	addEntity: (entity) =>
		{ :position, :shape } = entity\get()
		@world\add(entity, position.x, position.y, shape.width, shape.height)
		@

	queryPoint: (point) => @world\queryPoint(point\toTuple())

	update: (dt) =>
		@tiled\update(dt)

	draw: () =>
		@tiled\draw()

	setDrawRange: (...) => @tiled\setDrawRange(...)

	drawCollisions: (color = Color(255, 0, 0, 255)) =>
		love.graphics.setColor(color)
		@tiled\bump_draw(@world)
		love.graphics.setColor(Color(255, 255, 255, 255))
