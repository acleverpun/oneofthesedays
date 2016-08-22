Audio = require('lib/audio')
GuiState = require('lib/states/gui')
ZoneState = require('lib/states/zone')

class TitleState extends GuiState
	new: (...) =>
		super(...)
		@music = Audio('vendor/wave/music.wav', 'stream')
		@music\getSound()\setLooping(true)
		@sound = Audio('vendor/wave/sound.wav', 'static')

	enter: (...) =>
		super(...)
		@music\play()

	update: (...) =>
		super(...)

		@gui.layout\row(0, 200)

		self.buttonStart = @gui\Button('Start', @gui.layout\row(200, 20))
		self.buttonQuit = @gui\Button('Quit', @gui.layout\row(200, 20))

		if self.buttonStart.hit then @\startGame()
		if self.buttonQuit.hit then @\quitGame()

	draw: (...) =>
		super(...)
		love.graphics.print({ { 0, 150, 200 }, 'One of these days...' }, 200, 100)

	keypressed: (key) =>
		super(key)
		if key == 'return' then @\startGame()
		if key == 'escape' then @\quitGame()

	startGame: () =>
		@switch(ZoneState('sample_map.lua'))
		@sound\play()

	quitGame: () =>
		love.event.quit()
