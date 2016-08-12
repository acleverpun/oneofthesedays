gamestate = require 'vendor/hump/gamestate'
EventManager = require('lib/event-manager')

class State
	new: () =>
		@events = EventManager()
		@gamestate = gamestate

	keypressed: (key) =>
		if key == 'q' then love.event.quit()
