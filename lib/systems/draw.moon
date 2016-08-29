anim8 = require('vendor/anim8/anim8')
System = require('lib/systems/system')
Color = require('lib/display/color')

class DrawSystem extends System
	draw: () =>
		targets = @getTargets()
		drawn = {}

		for entity in *targets.sprites
			if drawn[entity] then continue
			drawn[entity] = true

			{ :sprite, :shape, :point } = entity\getAll()
			love.graphics.draw(sprite.image, sprite.quad, point.x, point.y, sprite.rotation, sprite.scale.x, sprite.scale.y)

		for entity in *targets.polygons
			if drawn[entity] then continue
			drawn[entity] = true

			{ :shape, :point, :color } = entity\getAll()
			if not color then color = Color(255, 0, 0)
			r, g, b, a = love.graphics.getColor()
			love.graphics.setColor(color)
			love.graphics.rectangle('fill', point.x, point.y, shape.width, shape.height)
			love.graphics.setColor(r, g, b, a)

	requires: () => {
		sprites: { 'sprite', 'shape', 'point' },
		polygons: { 'shape', 'point' },
	}
