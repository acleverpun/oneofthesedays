(ProxyClass) ->
	ToysProxy = class
		@__inherited: (child) =>
			child.name = child.__name

		new: (parent) =>
			@proxy = ProxyClass(parent)
			@class = @@

	for key, value in pairs ProxyClass.__instanceDict
		if type(value) == 'function'
			ToysProxy.__base[key] = (...) =>
				@proxy[key](@proxy, ...)

	return ToysProxy
