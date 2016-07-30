gamestate = require 'vendor/hump/gamestate'
suit = require 'vendor/SUIT'
State = require 'lib/states/state'
GameState = require 'lib/states/game'

class TitleState extends State
	update: () =>
		if super.draw then super()

		suit.layout\reset(0, 0)

		suit.layout\row(0, 200)

		buttonStart = suit.Button('Start', suit.layout\row(200, 20))
		suit.layout\row(0, 20)
		buttonQuit = suit.Button('Quit', suit.layout\row(200, 20))

		if buttonStart.hit then gamestate.push(GameState())
		if buttonQuit.hit then love.event.quit()

	draw: () =>
		if super.draw then super()

		suit.draw()

		love.graphics.print({ { 0, 150, 200 }, 'One of these days...' }, 200, 100)

	keypressed: (key) =>
		if super.keypressed then super(key)
		suit.keypressed(key)
		if key == 'escape' then love.event.quit()

	textinput: (text) =>
		if super.textinput then super(text)
		suit.textinput(key)
