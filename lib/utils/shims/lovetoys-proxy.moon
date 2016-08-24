Base = require('lib/base')

(ProxyClass) ->
	ToysProxy = class extends Base
		new: (...) =>
			super()
			@proxy = ProxyClass(...)

	for key, value in pairs ProxyClass.__instanceDict
		if _.isFunction(value)
			ToysProxy.__base[key] = (...) =>
				@proxy[key](@proxy, ...)

	return ToysProxy
