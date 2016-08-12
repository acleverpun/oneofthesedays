(ProxyClass) ->
	ToysProxy = class
		new: (parent) =>
			@proxy = ProxyClass(parent)

	for key, value in pairs ProxyClass.__instanceDict
		if type(value) == 'function'
			ToysProxy.__base[key] = (...) =>
				@proxy[key](@proxy, ...)

	return ToysProxy
