suit = require('vendor/SUIT')
Scene = require('lib/scenes/scene')

class GuiScene extends Scene

	new: () =>
		super()
		@gui = suit.new()

	update: (dt) =>
		super(dt)
		@gui.layout\reset(0, 0, 20, 20)

	draw: () =>
		super()
		@gui\draw()

	keypressed: (key) =>
		super(key)
		@gui\keypressed(key)

	textinput: (text) =>
		@gui\textinput(text)
