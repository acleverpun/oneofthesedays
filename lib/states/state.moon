gamestate = require 'vendor/hump/gamestate'
{ :EventManager } = require('vendor/lovetoys/lovetoys')

class State
	new: () =>
		@events = EventManager()
		@gamestate = gamestate

	keypressed: (key) =>
		if key == 'q' then love.event.quit()
