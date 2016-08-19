STI = require('vendor/sti/sti')
State = require('lib/states/state')
MapLayer = require('lib/map-layer')
PauseState = require('lib/states/pause')
entities = require('lib/entities')
Player = require('lib/entities/player')
DrawSystem = require('lib/systems/draw')
ControlSystem = require('lib/systems/control')

class GameState extends State
	new: (@mapName) =>
		super()

		@map = STI(@mapName)

		for object in *@map.layers.entities.objects
			entity = entities(object.type)(object.x, object.y - @map.tileheight)
			if object.name == 'player'
				@player = entity

		entityLayer = MapLayer(@map, 3)
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

		love.graphics.scale(scale)
		love.graphics.translate(-tx, -ty)

		@map\setDrawRange(0, 0, windowWidth, windowHeight)
		@map\draw()

		super()

	keypressed: (key) =>
		super(key)
		if key == 'escape' then @states.push(PauseState())
