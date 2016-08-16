System = require('lib/systems/system')

class DrawSystem extends System
	draw: () =>
		for entity in *@getTargets()
			position = entity\get('Position')
			drawable = entity\get('Drawable')

			r, g, b, a = love.graphics.getColor()
			love.graphics.setColor(drawable.color)
			love.graphics.rectangle('fill', position.x, position.y, drawable.width, drawable.height)
			love.graphics.setColor(r, g, b, a)

	requires: () =>
		{ 'Drawable', 'Position' }
