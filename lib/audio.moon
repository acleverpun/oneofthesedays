wave = require('vendor/wave/wave')

class Audio
	new: (@path, @type = 'stream') =>
		@sound = wave\newSource(@path, @type)

	getSound: () => @sound

	proxy: (method, ...) =>
		args = ...
		pcall(() -> @sound\play(args))

	play: (...) => @proxy('play', ...)
	stop: (...) => @proxy('stop', ...)
	pause: (...) => @proxy('pause', ...)
	resume: (...) => @proxy('resume', ...)
