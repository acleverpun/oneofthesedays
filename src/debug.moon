inspect = require('vendor/inspect/inspect')

dump = (value, depth) ->
	output = ''
	if _.isTable(value) and value.__class then output ..= "#{value.__class.__name}:"
	output ..= inspect(value, { :depth })
	return output

export p = (...) ->
	args = { ... }
	depth = if #args == 1 then 2 else 1
	output = ''
	for value in *args
		if #output > 0 then output ..= '\t'
		output ..= dump(value, depth)
	print output

export d = (value, depth = 2) ->
	print dump(value, depth)
