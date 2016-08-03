gamestate = require 'vendor/hump/gamestate'

class State
	new: () =>
		@events = EventManager()
		@gamestate = gamestate

	keypressed: (key) =>
		if key == 'q' then love.event.quit()
