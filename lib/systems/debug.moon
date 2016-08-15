System = require('lib/systems/system')

class DebugSystem extends System
	new: (@state) =>
		super()

	update: () =>
		@fps = love.timer.getFPS()
		@offset = 10

	draw: () =>
		@debug('FPS', @fps)
		@debug('state', @state.__class.__name)

	debug: (key, value) =>
		love.graphics.print({ { 255, 0, 100 }, key .. ': ', { 255, 255, 100 }, value }, 10, @offset)
		@offset += 20
