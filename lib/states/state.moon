states = require 'vendor/hump/gamestate'
Engine = require('lib/engine')
EventManager = require('lib/event-manager')

class State
	new: () =>
		@engine = Engine()
		@events = EventManager()
		@states = states

	draw: () =>
		@engine\draw(dt)

	update: (dt) =>
		@engine\update(dt)

	keypressed: (key) =>
		if key == 'q' then love.event.quit()
