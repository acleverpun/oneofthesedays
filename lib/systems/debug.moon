System = require('vendor/secs/lib/system')
Color = require('lib/display/color')
Direction = require('lib/geo/direction')

class DebugSystem extends System

	active: false
	x: 10

	new: (@scene) =>

	update: () =>
		@y = 10
		@fps = love.timer.getFPS()

	draw: () =>
		@debug('FPS', @fps)
		@debug('scene', @scene.__class.__name)

		if @scene.map.id then @debug('map', @scene.map.id)

		if player = @scene.player
			x = math.floor(player.position.x)
			y = math.floor(player.position.y)
			@debug('position', "#{x}, #{y}")
			if player.velocity then @debug('direction', "#{Direction\getHeadingName(player.velocity)}")
			@debug('animation', "#{player.animationList.current}")

	debug: (key, value) =>
		love.graphics.print({ Color(255, 0, 100), key .. ': ', Color(255, 255, 100), value }, @x, @y)
		@y += 20

	onToggle: (isActive) =>
		if not @scene.map then return
		if entityLayer = @scene.map.layers.entities
			entityLayer.visible = isActive
