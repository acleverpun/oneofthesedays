System = require('lib/systems/system')
Color = require('lib/display/color')

class DebugSystem extends System
	new: (@scene) =>
		super()
		@x = 10

	update: () =>
		@y = 10
		@fps = love.timer.getFPS()

	draw: () =>
		@debug('FPS', @fps)
		@debug('scene', @scene.__class.__name)

		if @scene.mapName then @debug('map', @scene.mapName)

		if player = @scene.player
			x = math.floor(player.position.x)
			y = math.floor(player.position.y)
			@debug('position', "#{x}, #{y}")
			@debug('direction', "#{player.direction.key}")

	debug: (key, value) =>
		love.graphics.print({ Color(255, 0, 100), key .. ': ', Color(255, 255, 100), value }, @x, @y)
		@y += 20
