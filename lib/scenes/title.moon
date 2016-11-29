Audio = require('lib/utils/audio')
GuiScene = require('lib/scenes/gui')
AreaScene = require('lib/scenes/area')
{ :Color } = require('vendor/hug/lib/display')

class TitleScene extends GuiScene

	new: (...) =>
		super(...)
		@music = Audio('vendor/wave/music.wav', 'stream')
		@music\setLooping(true)
		@sound = Audio('vendor/wave/sound.wav', 'static')

	enter: (...) =>
		super(...)
		@music\play()

	update: (...) =>
		super(...)

		@gui.layout\row(0, 200)

		self.buttonStart = @gui\Button('Start', @gui.layout\row(200, 20))
		self.buttonPlayground = @gui\Button('Playground', @gui.layout\row(200, 20))
		self.buttonQuit = @gui\Button('Quit', @gui.layout\row(200, 20))

		if self.buttonStart.hit then @\startGame()
		if self.buttonPlayground.hit then @\startPlayground()
		if self.buttonQuit.hit then @\quitGame()

	draw: (...) =>
		super(...)
		love.graphics.print({ Color(0, 150, 200), 'One of these days...' }, 200, 100)

	keypressed: (key) =>
		super(key)
		if key == 'space' then @\startGame()
		if key == 'return' then @\startPlayground()
		if key == 'escape' then @\quitGame()

	startGame: () =>
		@switch(AreaScene('rocket.lua'))
		@sound\play()

	startPlayground: () =>
		@switch(AreaScene('sample_map.lua'))
		@sound\play()

	quitGame: () =>
		love.event.quit()
