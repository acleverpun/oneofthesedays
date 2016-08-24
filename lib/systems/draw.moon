System = require('lib/systems/system')

class DrawSystem extends System
	draw: () =>
		for entity in *@getTargets()
			{ :drawable, :point } = entity\getAll()

			r, g, b, a = love.graphics.getColor()
			love.graphics.setColor(drawable.color)
			love.graphics.rectangle('fill', point.x, point.y, drawable.width, drawable.height)
			love.graphics.setColor(r, g, b, a)

	requires: () => { 'Drawable', 'Point' }
