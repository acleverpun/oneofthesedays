{ System: ToysSystem } = require('vendor/lovetoys/lovetoys')
ToysProxy = require('lib/utils/shims/lovetoys-proxy')

class System extends ToysProxy(ToysSystem)

	toggleActive: (...) =>
		isActive = super(...)
		if isActive and _.isFunction(@onEnable) then @onEnable()
		elseif not isActive and _.isFunction(@onDisable) then @onDisable()
		if _.isFunction(@onToggle) then @onToggle(isActive)
