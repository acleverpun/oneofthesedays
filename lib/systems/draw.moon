System = require('lib/systems/system')

class DrawSystem extends System
	draw: () =>
		for entity in *@getTargets()
			{ :rectangle, :point } = entity\getAll()

			r, g, b, a = love.graphics.getColor()
			love.graphics.setColor(rectangle.color)
			love.graphics.rectangle('fill', point.x, point.y, rectangle.width, rectangle.height)
			love.graphics.setColor(r, g, b, a)

	requires: () => { 'Rectangle', 'Point' }
