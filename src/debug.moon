inspect = require('vendor/inspect/inspect')
{ :run } = require('vendor/hug')

love.errhand = (err) ->
	-- error
	print('\nERROR:\n', err)

	-- sourcemap
	file, line = string.match(err, '^([^:]+).lua:(%d+)')
	output = run("moonc -X #{file}.moon | grep -E '\\s#{line}:'")
	print('\nSOURCEMAP:\n', output)

	-- stacktrace
	print('STACKTRACE:')
	print(debug.traceback())

traverse = (value, depth, hideMeta = false) ->
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
		output ..= traverse(value, depth, true)
	print output

export dump = (value, depth = 2) ->
	print traverse(value, depth)
