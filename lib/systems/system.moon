{ System: ToysSystem } = require('vendor/lovetoys/lovetoys')
ToysProxy = require('lib/utils/shims/lovetoys-proxy')

class System extends ToysProxy(ToysSystem)

	new: () =>
		if _.isFunction(@onAddEntity) then @proxy.onAddEntity = @onAddEntity

	toggleActive: (...) =>
		isActive = super(...)
		if isActive and _.isFunction(@onEnable) then @onEnable()
		elseif not isActive and _.isFunction(@onDisable) then @onDisable()
		if _.isFunction(@onToggle) then @onToggle(isActive)
