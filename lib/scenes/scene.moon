Class = require('lib/class')
scenes = require('vendor/hump/gamestate')
Secs = require('lib/secs')
Transition = require('lib/transition')
EventManager = require('lib/event-manager')
DebugSystem = require('lib/systems/debug')

class Scene extends Class

	new: () =>
		@secs = Secs()
		@events = EventManager()
		@scenes = scenes

		debugSystem = DebugSystem(@)
		@secs\addSystem(debugSystem, 'update')
		@secs\addSystem(debugSystem, 'draw')
		@secs\stopSystem(DebugSystem.name)

	enter: (@previous) =>

	update: (dt) =>
		@secs\update(dt)

	draw: () =>
		@secs\draw()

	keypressed: (key) =>
		if key == 'q' then love.event.quit()
		if key == '`'
			@secs\toggleSystem(DebugSystem.name)
			@DEBUG = not @DEBUG

	switch: (scene, data, ...) =>
		transition = Transition(@, scene, data)
		@scenes.switch(scene, transition, ...)

	push: (scene, data, ...) =>
		transition = Transition(@, scene, data)
		@scenes.push(scene, transition, ...)

	pop: (...) =>
		@scenes.pop(...)
