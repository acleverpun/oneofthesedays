-- class Loader
-- 	new: (@handler) =>
-- 		@cache = {}
--
-- 	__index: (key) =>
-- 		print 'hi'
--
-- 	get: (key, force = false) =>
-- 		if @cache[key] and not force then return @cache[key]
--
-- 		value = @handler(key)
-- 		@cache[key] = value
-- 		return value

return (handler) ->
	cache = {}
	__cache = {}

	setmetatable(cache, {
		__index: (key) =>
			if __cache[key] then return __cache[key]

			value = handler(key)
			cache[key] = value
			__cache[key] = value
			return value
	})

	return cache
