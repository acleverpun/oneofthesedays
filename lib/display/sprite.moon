Caste = require('vendor/caste/lib/caste')
{ :Vector } = require('vendor/hug/lib/geo')

class Sprite extends Caste

	new: (imagePath, offset, @shape, @scale = Vector(1, 1), @rotation = 0) =>
		@image = love.graphics.newImage("assets/sprites/#{imagePath}")
		@quad = love.graphics.newQuad(offset.x, offset.y, @shape.width, @shape.height, @image\getDimensions())
