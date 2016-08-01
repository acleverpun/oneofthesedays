suit = require 'vendor/SUIT'
State = require 'lib/states/state'

class GuiState extends State
	update: () =>
		suit.layout\reset(0, 0, 20, 20)

	draw: () =>
		suit.draw()

	keypressed: (key) =>
		super(key)
		suit.keypressed(key)

	textinput: (text) =>
		suit.textinput(text)
