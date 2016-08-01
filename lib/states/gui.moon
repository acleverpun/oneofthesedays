suit = require 'vendor/SUIT'
State = require 'lib/states/state'

class GuiState extends State
	enter: () =>
		@gui = suit.new()

	update: () =>
		@gui.layout\reset(0, 0, 20, 20)

	draw: () =>
		@gui\draw()

	keypressed: (key) =>
		super(key)
		@gui\keypressed(key)

	textinput: (text) =>
		@gui\textinput(text)
