Class = require('lib/class')
scenes = require('vendor/hump/gamestate')
Engine = require('lib/engine')
Transition = require('lib/transition')
EventManager = require('lib/event-manager')
DebugSystem = require('lib/systems/debug')

class Scene extends Class
	new: () =>
		@engine = Engine()
		@events = EventManager()
		@scenes = scenes

		debugSystem = DebugSystem(@)
		@engine\addSystem(debugSystem, 'update')
		@engine\addSystem(debugSystem, 'draw')
		@engine\stopSystem(DebugSystem.name)

	enter: (@previous) =>

	update: (dt) =>
		@engine\update(dt)

	draw: () =>
		@engine\draw()

	keypressed: (key) =>
		if key == 'q' then love.event.quit()
		if key == '`'
			@engine\toggleSystem(DebugSystem.name)
			@DEBUG = not @DEBUG

	switch: (scene, data, ...) =>
		transition = Transition(@, scene, data)
		@scenes.switch(scene, transition, ...)

	push: (scene, data, ...) =>
		transition = Transition(@, scene, data)
		@scenes.push(scene, transition, ...)

	pop: (...) =>
		@scenes.pop(...)
