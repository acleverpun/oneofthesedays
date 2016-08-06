GuiState = require 'lib/states/gui'
WorldState = require 'lib/states/world'

class TitleState extends GuiState
	update: () =>
		super()

		@gui.layout\row(0, 200)

		self.buttonStart = @gui\Button('Start', @gui.layout\row(200, 20))
		self.buttonQuit = @gui\Button('Quit', @gui.layout\row(200, 20))

		if self.buttonStart.hit then @\startGame()
		if self.buttonQuit.hit then @\quitGame()

	draw: () =>
		super()
		love.graphics.print({ { 0, 150, 200 }, 'One of these days...' }, 200, 100)

	keypressed: (key) =>
		super(key)
		if key == 'enter' then @\startGame()
		if key == 'escape' then @\quitGame()

	startGame: () =>
		@gamestate.switch(WorldState())

	quitGame: () =>
		love.event.quit()
