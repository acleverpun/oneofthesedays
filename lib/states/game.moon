State = require('lib/states/state')
PauseState = require('lib/states/pause')
Player = require('lib/entities/player')

class GameState extends State
	new: (...) =>
		super(...)
		@player = Player()

	draw: () =>
		super()
		love.graphics.print('hi', 200, 100)

	keypressed: (key) =>
		super(key)
		if key == 'escape' then @states.push(PauseState())
