State = require('lib/states/state')

class GameState extends State
	draw: () ->
		love.graphics.print('hi', 200, 100)
