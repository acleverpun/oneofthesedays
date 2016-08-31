anim8 = require('vendor/anim8/anim8')
Sprite = require('lib/display/sprite')

class AnimatedSprite extends Sprite

	new: (imagePath, offset, @shape, @scale, @rotation = 0) =>
		super(imagePath, offset, @shape, @scale, @rotation)
		g = anim8.newGrid(16, 16, @image\getWidth(), @image\getHeight(), offset.x, offset.y, 2)
		@animation = anim8.newAnimation(g('1-2', 1), 0.2)
