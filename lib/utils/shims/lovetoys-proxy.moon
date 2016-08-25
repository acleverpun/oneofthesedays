Class = require('lib/class')

(ProxyClass) ->
	ToysProxy = class extends Class
		new: (...) =>
			super()
			@proxy = ProxyClass(...)

	for key, value in pairs ProxyClass.__instanceDict
		if _.isFunction(value)
			ToysProxy.__base[key] = (...) =>
				@proxy[key](@proxy, ...)

	return ToysProxy
