inspect = require('vendor/inspect/inspect')

dump = (value, depth, hideMeta = false) ->
	output = ''
	if _.isTable(value) and value.__class then output ..= "#{value.__class.__name}:"

	options = { :depth }
	if hideMeta then options.process = (item, path) -> if path[#path] != inspect.METATABLE then return item

	output ..= inspect(value, options)
	return output

export log = (...) ->
	args = { ... }
	depth = if #args == 1 then 2 else 1
	output = ''
	for value in *args
		if #output > 0 then output ..= '\t'
		output ..= dump(value, depth, true)
	print output

export debug = (value, depth = 2) ->
	print dump(value, depth)
