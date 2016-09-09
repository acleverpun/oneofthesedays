Class = require('lib/class')

class AnimationList extends Class

	current: 'default'

	new: (@entity, animations, options = {}) =>
		if options.current then @current = options.current

		for name, animation in pairs(animations)
			@[name] = animation
			animation.name = name
			animation\init(options)

		@set(@[@current])

	set: (animation) =>
		if _.isString(animation) then animation = @[animation]
		unless animation then error 'No animation specified.'
		@current = animation.name
		@entity\set('animation', animation)
