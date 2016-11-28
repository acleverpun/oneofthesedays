anim8 = require('vendor/anim8/anim8')
Caste = require('vendor/caste/lib/caste')
{ :Vector } = require('vendor/hug/lib/geo')

class Animation extends Caste

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
		@value = anim8.newAnimation(g(unpack(@options.frameData)), @options.duration)
