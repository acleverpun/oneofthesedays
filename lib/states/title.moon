State = require('lib/states/state')

class TitleState extends State
	draw: () =>
		love.graphics.print('One of these days...', 200, 100)
		love.graphics.print('Press `Space` to start.', 300, 200)
		love.graphics.print('Press `Escape` at any time to quit to main menu.', 300, 220)
		love.graphics.print('Press `Escape` to quit.', 300, 240)
