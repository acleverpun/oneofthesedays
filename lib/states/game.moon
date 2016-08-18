STI = require 'vendor/sti/sti'
State = require 'lib/states/state'
PauseState = require 'lib/states/pause'
Player = require 'lib/entities/player'
DrawSystem = require 'lib/systems/draw'
ControlSystem = require 'lib/systems/control'

class GameState extends State
	new: (mapName) =>
		super()

		@map = STI(mapName)

		@player = Player(400, 400)

		@engine\addSystem(DrawSystem())
		@engine\addSystem(ControlSystem())
		@engine\addEntity(@player)

		@windowWidth = love.graphics.getWidth()
		@windowHeight = love.graphics.getHeight()

	update: (dt) =>
		super(dt)
		@map\update(dt)

	draw: () =>
		super()
		@map\setDrawRange(-0, -0, @windowWidth, @windowHeight)
		@map\draw()
		love.graphics.print({ { 255, 255, 255 }, 'hi' }, 200, 100)

	keypressed: (key) =>
		super(key)
		if key == 'escape' then @states.push(PauseState())
