System = require('lib/systems/system')
Color = require('lib/display/color')

class DebugSystem extends System

	x: 10

	new: (@scene) =>

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

	onToggle: (isActive) =>
		if not @scene.map then return
		if entityLayer = @scene.map.layers.entities
			entityLayer.visible = isActive
