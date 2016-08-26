STI = require('vendor/sti/sti')
bump = require('vendor/bump/bump')
State = require('lib/states/state')
MapLayer = require('lib/map-layer')
PauseState = require('lib/states/pause')
entities = require('lib/entities')
DrawSystem = require('lib/systems/draw')
ControlSystem = require('lib/systems/control')
Color = require('lib/display/color')
Point = require('lib/geo/point')
Direction = require('lib/enums/direction')

class AreaState extends State
	new: (@mapName) =>
		super()

		@map = STI("assets/maps/#{@mapName}", { 'bump' })
		@world = bump.newWorld(@map.tilewidth)
		@map\bump_init(@world)
		@scale = 1

	enter: (previous, transition) =>
		super(previous)

		if transition.player
			@player = transition.player\clone(@)
		needsDoor = not not transition.player

		doors = {}
		for object in *@map.layers.entities.objects
			if object.type == 'Player' and @player then continue
			if object.type == 'zones/DoorZone' then _.push(doors, object)

			entity = entities[object.type](@, object)
			if object.type == 'Player'
				@player = entity
				continue
			@addEntityToWorld(entity, object)

		assert @player
		door = doors[1]
		if needsDoor
			@player.point.x = door.x
			@player.point.y = door.y

		-- Handle specific spawn points
		if toPoint = transition.toPoint
			if toPoint.x then @player.point.x = toPoint.x
			if toPoint.y then @player.point.y = toPoint.y
		-- Handle door offsets
		-- if transition.offset
		-- 	if transition.offset.x then @player.point.x += transition.offset.x
		-- 	if transition.offset.y then @player.point.y += transition.offset.y
		-- Handle direction
		if transition.direction
			if transition.direction == Direction.NORTH then @player.point.y += @player.data.height
			if transition.direction == Direction.SOUTH then @player.point.y -= @player.data.height
			if transition.direction == Direction.WEST then @player.point.x += @player.data.width
			if transition.direction == Direction.EAST then @player.point.x -= @player.data.width

		@addEntityToWorld(@player, @player\getData())

		entityLayer = MapLayer(@map, 'entities')
		entityLayer.engine\addSystem(DrawSystem())
		entityLayer.engine\addSystem(ControlSystem())
		entityLayer.engine\addEntity(@player)

	addEntityToWorld: (entity, data) =>
		@world\add(entity, data.x, data.y, data.width, data.height)

	update: (dt) =>
		super(dt)
		@map\update(dt)
		@windowWidth = love.graphics.getWidth()
		@windowHeight = love.graphics.getHeight()
		tx = math.floor(@player.point.x - @windowWidth / @scale / 2)
		ty = math.floor(@player.point.y - @windowHeight / @scale / 2)
		@translation = Point(tx, ty)

	draw: () =>
		love.graphics.push()
		love.graphics.scale(@scale)
		love.graphics.translate(-@translation.x, -@translation.y)
		@map\setDrawRange(@translation.x, @translation.y, @windowWidth, @windowHeight)
		@map\draw()

		if @DEBUG
			love.graphics.setColor(Color(255, 0, 0, 255))
			@map\bump_draw(@world)
			love.graphics.setColor(Color(255, 255, 255, 255))

		love.graphics.pop()

		super()

	keypressed: (key) =>
		super(key)
		if key == 'escape' then @push(PauseState())

	mousepressed: (x, y, button) =>
		if @DEBUG and button == 2
			eventPoint = Point(x, y)
			-- TODO: Make work not just for player
			point = eventPoint + @translation - Point(200, 150)

			items, len = @world\queryPoint(point\toTuple())
			if len > 0 then d items
