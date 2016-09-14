Class = require('lib/class')
scenes = require('vendor/hump/gamestate')
Secs = require('lib/secs/secs')
Transition = require('lib/transition')
EventEmitter = require('lib/utils/event-emitter')
DebugSystem = require('lib/systems/debug')

class Scene extends Class

	new: () =>
		@secs = Secs()
		@events = EventEmitter()
		@scenes = scenes

		@secs\addSystem(DebugSystem(@))
		@secs\stopSystem(DebugSystem)

	enter: (@previous) =>

	update: (dt) =>
		@secs\update(dt)

	draw: () =>
		@secs\draw()

	keypressed: (key) =>
		if key == 'q' then love.event.quit()
		if key == '`'
			@secs\toggleSystem(DebugSystem)
			@DEBUG = not @DEBUG

	switch: (scene, data, ...) =>
		transition = Transition(@, scene, data)
		@scenes.switch(scene, transition, ...)

	push: (scene, data, ...) =>
		transition = Transition(@, scene, data)
		@scenes.push(scene, transition, ...)

	pop: (...) =>
		@scenes.pop(...)
