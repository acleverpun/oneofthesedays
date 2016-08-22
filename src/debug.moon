inspect = require('vendor/inspect/inspect')

export p = (...) ->
	depth = 2
	output = ''
	for value in *{ ... }
		if #output > 0 then output ..= '\t'
		output ..= inspect(value, { :depth })
	print output

export d = (value, depth = 2) ->
	print inspect(value, { :depth })
