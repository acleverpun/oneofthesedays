class Loader
	new: (@handler) =>
		@cache = {}

	get: (name, force = false) =>
		if @cache[name] and not force then return @cache[name]

		value = @handler(name)
		@cache[name] = value
		return value
