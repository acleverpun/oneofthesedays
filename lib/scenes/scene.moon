Caste = require('vendor/caste/lib/caste')
scenes = require('vendor/hump/gamestate')
Secs = require('vendor/secs/lib/secs')
EventEmitter = require('vendor/secs/lib/event-emitter')
Transition = require('lib/transition')
DebugSystem = require('lib/systems/debug')

class Scene extends Caste

	new: () =>
		@secs = Secs()
		@events = EventEmitter()
		@scenes = scenes

		@secs\addSystem(DebugSystem(@))

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
