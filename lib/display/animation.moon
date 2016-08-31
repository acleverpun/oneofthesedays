anim8 = require('vendor/anim8/anim8')
Class = require('lib/class')
Vector = require('lib/geo/vector')

class Animation extends Class

	new: (imagePath, offset, @shape, @scale = Vector(1, 1), @rotation = 0) =>
		super()
		@image = love.graphics.newImage("assets/sprites/#{imagePath}")
		g = anim8.newGrid(16, 16, @image\getWidth(), @image\getHeight(), offset.x, offset.y, 2)
		@animation = anim8.newAnimation(g('1-2', 1), 0.2)
