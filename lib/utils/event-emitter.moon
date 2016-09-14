Class = require('lib/class')

class EventEmitter extends Class

	new: () =>
		@listeners = {}

	on: (event, listener) =>
		if not @listeners[event] then @listeners[event] = {}
		table.insert(@listeners[event], listener)

	once: (event, listener) => @many(event, 1, listener)
	many: (event, ttl, listener) =>
		wrapper = (...) =>
			ttl -= 1
			if ttl == 0 then @off(event, wrapper)
			listener(...)

	emit: (event, ...) =>
		for listener in *@listeners[event]
			listener(...)

	off: (event, listener) =>
	removeListener: (...) => @off(...)
	removeAllListeners: (event) =>

	eventNames: () =>
		names = {}
		for name, listener in pairs(@listeners)
			table.insert(names, name)
		return names
