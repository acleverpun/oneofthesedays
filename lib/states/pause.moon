GuiState = require 'lib/states/gui'

class GameState extends GuiState
	update: () =>
		super()

		@gui.layout\row(0, 200)

		@buttonResume = @gui\Button('Resume', @gui.layout\row(200, 20))
		@buttonQuit = @gui\Button('Quit', @gui.layout\row(200, 20))

		if @buttonResume.hit then @unpause()
		if @buttonQuit.hit then love.event.quit()

	draw: () =>
		super()

		love.graphics.print('PAUSED', 200, 100)

	keypressed: (key) =>
		super(key)
		if key == 'escape' then @unpause()

	unpause: () =>
		@gamestate.pop()
