System = require('lib/systems/system')
Color = require('lib/display/color')

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
			x = math.floor(player.point.x)
			y = math.floor(player.point.y)
			@debug('position', "#{x}, #{y}")

	debug: (key, value) =>
		love.graphics.print({ Color(255, 0, 100), key .. ': ', Color(255, 255, 100), value }, @x, @y)
		@y += 20
