System = require('lib/systems/system')
Color = require('lib/display/color')

class RenderSystem extends System

	update: (dt) =>
		for entity in *@getTargets().animated
			{ :animation } = entity\getAll()
			animation.animation\update(dt)

	draw: () =>
		targets = @getTargets()
		drawn = {}

		for entity in *targets.animated
			if drawn[entity] then continue
			drawn[entity] = true
			@drawSprite(entity)

		for entity in *targets.sprites
			if drawn[entity] then continue
			drawn[entity] = true
			@drawSprite(entity)

		for entity in *targets.polygons
			if drawn[entity] then continue
			drawn[entity] = true
			{ :shape, :position, :color } = entity\getAll()
			if not color then color = Color(255, 0, 0)
			r, g, b, a = love.graphics.getColor()
			love.graphics.setColor(color)
			love.graphics.rectangle('fill', position.x, position.y, shape.width, shape.height)
			love.graphics.setColor(r, g, b, a)

	drawSprite: (entity) =>
		{ :sprite, :animation, :shape, :position } = entity\getAll()
		isAnimated = not sprite
		if isAnimated then sprite = animation

		spritePosition = position\clone()
		spritePosition.x += (shape.width - sprite.shape.width) / 2
		spritePosition.y += (shape.height - sprite.shape.height)

		if isAnimated
			sprite.animation\draw(sprite.image, spritePosition.x, spritePosition.y, sprite.options.rotation, sprite.options.scale.x, sprite.options.scale.y)
		else
			love.graphics.draw(sprite.image, sprite.quad, spritePosition.x, spritePosition.y, sprite.rotation, sprite.scale.x, sprite.scale.y)


	requires: () => {
		animated: { 'animation', 'shape', 'position' },
		sprites: { 'sprite', 'shape', 'position' },
		polygons: { 'shape', 'position' },
	}
