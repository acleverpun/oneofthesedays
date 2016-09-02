anim8 = require('vendor/anim8/anim8')
Class = require('lib/class')
Vector = require('lib/geo/vector')

class Animation extends Class

	@options: {
		scale: Vector(1, 1),
		rotation: 0
	}

	new: (frameData, @options = {}) =>
		@options.frameData = frameData

	init: (options) =>
		@options = _.defaults(@options, options, @@options)
		@shape = @options.shape
		@image = love.graphics.newImage("assets/sprites/#{@options.image}")
		g = anim8.newGrid(@shape.width, @shape.height, @image\getWidth(), @image\getHeight(), @options.offset.x, @options.offset.y, @options.border)
		@animation = anim8.newAnimation(g(unpack(@options.frameData)), @options.duration)
