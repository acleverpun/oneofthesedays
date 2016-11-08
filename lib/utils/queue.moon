Caste = require('vendor/caste/lib/caste')

class Queue extends Caste

	new: () =>
		@queue = {}

	__len: () => #@queue

	-- Inserts the specified element into this queue.
	add: (...) =>
		_.push(@queue, ...)
		return @

	-- Retrieves and removes the head of this queue.
	-- Returns `nil` if this queue is empty.
	poll: () =>
		entry = @queue[1]
		table.remove(@queue)
		return entry

	-- Retrieves and removes the head of this queue.
	-- This method differs from poll only in that it throws an exception if this queue is empty.
	remove: () =>
		entry = @poll()
		if not entry then error('Queue empty.')
		return entry

	-- Retrieves, but does not remove, the head of this queue.
	-- Returns `nil` if this queue is empty.
	peek: () => @queue[1]

	each: => coroutine.wrap ->
		for entry in *@queue
			coroutine.yield entry

	process: => coroutine.wrap ->
		while #@queue > 0
			coroutine.yield @remove()
