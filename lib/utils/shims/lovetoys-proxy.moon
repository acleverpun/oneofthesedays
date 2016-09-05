Class = require('lib/class')

(ProxyClass) ->
	init = () =>
		@proxy = ProxyClass()

	ToysProxy = class extends Class

		@__inherited: (child) =>
			super(child)

			-- Call setup code in constructor, so children do not need to call `super`
			constructor = child.__init
			child.__init = (...) =>
				init(@)
				constructor(@, ...)

		-- new: (...) => init(@, ...)

	for key, value in pairs ProxyClass.__instanceDict
		if _.isFunction(value)
			ToysProxy.__base[key] = (...) =>
				@proxy[key](@proxy, ...)

	return ToysProxy
