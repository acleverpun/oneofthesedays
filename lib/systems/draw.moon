System = require('lib/systems/system')
Color = require('lib/display/color')

class DrawSystem extends System
	draw: () =>
		for entity in *@getTargets()
			{ :shape, :point, :color } = entity\getAll()
			if not color then color = Color(255, 0, 0)

			r, g, b, a = love.graphics.getColor()
			love.graphics.setColor(color)
			love.graphics.rectangle('fill', point.x, point.y, shape.width, shape.height)
			love.graphics.setColor(r, g, b, a)

	requires: () => { 'Shape', 'Point' }
