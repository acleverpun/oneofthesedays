System = require('vendor/secs/lib/system')
Color = require('lib/display/color')
Direction = require('lib/geo/direction')

class RenderSystem extends System

	@criteria: System.Criteria({ 'shape', 'position' }, { 'animation', 'animationList', 'sprite' })

	new: () =>
		@animatedEntities = {}

	update: (dt) =>
		for entity in *@animatedEntities
			{ :animation, :animationList, :velocity } = entity\get()
			heading = Direction\getHeading(velocity)
			if animationList[heading] then animationList\set(heading)
			animation.value\update(dt)

	draw: () =>
		for entity in *@entities
			if entity\has('sprite') or entity\has('animation', 'animationList')
				@drawSprite(entity)
			else
				@drawPolygon(entity)

	drawPolygon: (entity) =>
		{ :shape, :position, :color } = entity\get()
		if not color then color = Color(255, 0, 0)
		r, g, b, a = love.graphics.getColor()
		love.graphics.setColor(color)
		love.graphics.rectangle('fill', position.x, position.y, shape.width, shape.height)
		love.graphics.setColor(r, g, b, a)

	drawSprite: (entity) =>
		{ :sprite, :animation, :shape, :position } = entity\get()
		isAnimated = not sprite
		if isAnimated then sprite = animation

		spritePosition = position\clone()
		spritePosition.x += (shape.width - sprite.shape.width) / 2
		spritePosition.y += (shape.height - sprite.shape.height)

		if isAnimated
			animation.value\draw(sprite.image, spritePosition.x, spritePosition.y, sprite.options.rotation, sprite.options.scale.x, sprite.options.scale.y)
		else
			love.graphics.draw(sprite.image, sprite.quad, spritePosition.x, spritePosition.y, sprite.rotation, sprite.scale.x, sprite.scale.y)

	onAdd: (entity) =>
		if entity\has('animation', 'animationList')
			table.insert(@animatedEntities, entity)

	onRemove: (entity) =>
		if entity\has('animation', 'animationList')
			for e = 1, #@animatedEntities
				if @animatedEntities[e] == entity then table.remove(@animatedEntities, e)
