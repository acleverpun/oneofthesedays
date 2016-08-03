State = require('lib/states/state')
PauseState = require('lib/states/pause')

class GameState extends State
	draw: () =>
		love.graphics.print('hi', 200, 100)

	keypressed: (key) =>
		super(key)
		if key == 'escape' then @gamestate.push(PauseState())
