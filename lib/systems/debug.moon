System = require('lib/systems/system')

class DebugSystem extends System
	new: (@state) =>
		super()
		@x = 10
		@mapName = @state.mapName

	update: () =>
		@y = 10
		@fps = love.timer.getFPS()

	draw: () =>
		@debug('FPS', @fps)
		@debug('state', @state.__class.__name)
		if @mapName then @debug('map', @mapName)

	debug: (key, value) =>
		love.graphics.print({ { 255, 0, 100 }, key .. ': ', { 255, 255, 100 }, value }, @x, @y)
		@y += 20
