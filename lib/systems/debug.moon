System = require('lib/systems/system')

class DebugSystem extends System
	new: (@state) =>
		super()
		@x = 10

	update: () =>
		@y = 10
		@fps = love.timer.getFPS()

	draw: () =>
		@debug('FPS', @fps)
		@debug('state', @state.__class.__name)

		if @state.mapName then @debug('map', @state.mapName)

		if player = @state.player
			point = player\get('Position')
			x = math.floor(point.x)
			y = math.floor(point.y)
			@debug('position', "#{x}, #{y}")

	debug: (key, value) =>
		love.graphics.print({ { 255, 0, 100 }, key .. ': ', { 255, 255, 100 }, value }, @x, @y)
		@y += 20
