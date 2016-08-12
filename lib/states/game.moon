State = require('lib/states/state')
PauseState = require('lib/states/pause')
Player = require('lib/entities/player')
Engine = require('lib/engine')

class GameState extends State
	init: () =>
		@engine = Engine()
		@player = Player()

	update: (dt) =>
		@engine\update(dt)

	draw: () =>
		@engine\draw(dt)
		love.graphics.print('hi', 200, 100)

	keypressed: (key) =>
		super(key)
		@engine\keypressed(key)
		if key == 'escape' then @gamestate.push(PauseState())
