gamestate = require 'vendor/hump/gamestate'
State = require('lib/states/state')

class GameState extends State
	draw: () =>
		love.graphics.print('hi', 200, 100)

	keypressed: (key) =>
		if super.keypressed then super(key)
		if key == 'escape' then gamestate.pop()
