GuiScene = require('lib/scenes/gui')

class PauseScene extends GuiScene

	update: (dt) =>
		super(dt)

		@gui.layout\row(0, love.graphics.getHeight() / 2)

		@buttonResume = @gui\Button('Resume', @gui.layout\row(200, 20))
		@buttonQuit = @gui\Button('Quit', @gui.layout\row(200, 20))

		if @buttonResume.hit then @unpause()
		if @buttonQuit.hit then love.event.quit()

	draw: () =>
		super()
		love.graphics.printf('GAME PAUSED', 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), 'center')

	keypressed: (key) =>
		if key == 'escape' then @unpause()
		super(key)

	unpause: () =>
		@scenes.pop()
