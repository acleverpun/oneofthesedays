State = require('lib/states/state')
PauseState = require('lib/states/pause')
Player = require('lib/entities/player')
DrawSystem = require('lib/systems/draw')

class GameState extends State
	new: () =>
		super()

		@player = Player(400, 400)

		@engine\addSystem(DrawSystem())
		@engine\addEntity(@player)

	draw: () =>
		super()
		love.graphics.print({ { 255, 255, 255 }, 'hi' }, 200, 100)

	keypressed: (key) =>
		super(key)
		if key == 'escape' then @states.push(PauseState())
