class Loader

	new: (handler) =>
		cache = {}

		meta = getmetatable(@)
		oldIndex = meta.__index

		meta.__index = (key) =>
			if value = cache[key]
				return value
			elseif value = handler(key)
				cache[key] = value
				return value
			elseif _.isFunction(oldIndex)
				return oldIndex(@, key)
			else
				return oldIndex[key]
