gamestate = require 'vendor/hump/gamestate'
suit = require 'vendor/SUIT'
GameState = require 'lib/states/game'
GuiState = require 'lib/states/gui'

class TitleState extends GuiState
	update: () =>
		super()

		suit.layout\row(0, 200)

		self.buttonStart = suit.Button('Start', suit.layout\row(200, 20))
		self.buttonQuit = suit.Button('Quit', suit.layout\row(200, 20))

		if self.buttonStart.hit then gamestate.switch(GameState())
		if self.buttonQuit.hit then love.event.quit()

	draw: () =>
		super()

		love.graphics.print({ { 0, 150, 200 }, 'One of these days...' }, 200, 100)

	keypressed: (key) =>
		super(key)

		if key == 'escape' then love.event.quit()
