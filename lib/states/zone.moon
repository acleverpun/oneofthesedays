STI = require('vendor/sti/sti')
bump = require('vendor/bump/bump')
State = require('lib/states/state')
MapLayer = require('lib/map-layer')
PauseState = require('lib/states/pause')
entities = require('lib/entities')
DrawSystem = require('lib/systems/draw')
ControlSystem = require('lib/systems/control')

class ZoneState extends State
	new: (@mapName) =>
		super()

		@boxWorld = love.physics.newWorld(0, 0)
		@map = STI("assets/maps/#{@mapName}", { 'bump' })
		@world = bump.newWorld(@map.tilewidth)
		@map\bump_init(@world)

	enter: (previous, spawnPoint) =>
		super(previous)

		for tile in *@map.layers.entities.objects
			entity = entities[tile.type](@world, tile)

			if tile.type == 'Player'
				@player = entity
				if spawnPoint
					if spawnPoint.x then tile.x = spawnPoint.x
					if spawnPoint.y then tile.y = spawnPoint.y

			@world\add(entity, tile.x, tile.y, tile.width, tile.height)

		entityLayer = MapLayer(@map, 'entities')
		entityLayer.engine\addSystem(DrawSystem())
		entityLayer.engine\addSystem(ControlSystem())
		entityLayer.engine\addEntity(@player)

	update: (dt) =>
		super(dt)
		@map\update(dt)

	draw: () =>
		scale = 2
		windowWidth = love.graphics.getWidth()
		windowHeight = love.graphics.getHeight()
		playerPosition = @player\get('Position')

		tx = math.floor(playerPosition.x - windowWidth / scale / 2)
		ty = math.floor(playerPosition.y - windowHeight / scale / 2)

		love.graphics.push()
		love.graphics.scale(scale)
		love.graphics.translate(-tx, -ty)
		@map\setDrawRange(tx, ty, windowWidth, windowHeight)
		@map\draw()

		if DEBUG
			love.graphics.setColor(255, 0, 0, 255)
			@map\bump_draw(@world)
			love.graphics.setColor(255, 255, 255, 255)

		love.graphics.pop()

		super()

	keypressed: (key) =>
		super(key)
		if key == 'escape' then @push(PauseState())
