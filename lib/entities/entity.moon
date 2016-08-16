{ Entity: ToysEntity } = require('vendor/lovetoys/lovetoys')
ToysProxy = require('lib/utils/shims/lovetoys-proxy')

getmetatable('').__index = (str, i) -> string.sub(str, i, i)
getmetatable('').__call = (str, i, j)   ->
	if type(i) != 'table' then return string.sub(str, i, j)
	t = {}
	for k, v in ipairs(i) do t[k] = string.sub(str, v, v)
	return table.concat(t)

class Entity extends ToysProxy(ToysEntity)
	getAll: () =>
		components = @getComponents()
		result = {}

		for key, value in pairs(components)
			lowerKey = "#{string.lower(key[1])}#{key(2)}"
			result[lowerKey] = value

		return result
