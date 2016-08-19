states = require('vendor/hump/gamestate')
Engine = require('lib/engine')
EventManager = require('lib/event-manager')
DebugSystem = require('lib/systems/debug')

class State
	new: () =>
		@engine = Engine()
		@events = EventManager()
		@states = states

		debugSystem = DebugSystem(@)
		@engine\addSystem(debugSystem, 'update')
		@engine\addSystem(debugSystem, 'draw')

	update: (dt) =>
		@engine\update(dt)

	draw: () =>
		@engine\draw()

	keypressed: (key) =>
		if key == 'q' then love.event.quit()
		if key == '`' then @engine\toggleSystem('DebugSystem')
