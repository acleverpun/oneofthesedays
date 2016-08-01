GameState = require 'lib/states/game'
GuiState = require 'lib/states/gui'

class TitleState extends GuiState
	update: () =>
		super()

		@gui.layout\row(0, 200)

		self.buttonStart = @gui\Button('Start', @gui.layout\row(200, 20))
		self.buttonQuit = @gui\Button('Quit', @gui.layout\row(200, 20))

		if self.buttonStart.hit then @gamestate.switch(GameState())
		if self.buttonQuit.hit then love.event.quit()

	draw: () =>
		super()

		love.graphics.print({ { 0, 150, 200 }, 'One of these days...' }, 200, 100)

	keypressed: (key) =>
		super(key)

		if key == 'escape' then love.event.quit()
